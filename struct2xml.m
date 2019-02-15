function str = struct2xml(aStruct)
    %% STRUCT2XML returns a string formatted as:
    %  <struct_name>
    %      <field name="field_name">field_value</field>
    %  <\struct_name>
    %  Usage:  string = struct2str(aStruct) 
    %% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
    %% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/struct2xml.m $ 
    %% Developed on Matlab 7.13.0.564 (R2011b) 
    %% $Id$ 

    str = '';
    flds = fields(aStruct);
    for f = 1:length(flds) %#ok<*FORFLG,*PFUNK>
        fval = aStruct.(flds{f});
        if (isnumeric(fval) || islogical(fval))
            fval = num2str(fval);
        elseif (isstruct(fval))
            fval = struct2str(fval);
        elseif (iscell(fval))
            fval = cell2str(fval);
        else
            fval = char(fval);
        end
        str = [str wrapInSeparatedBrackets(flds{f}, fval)]; %#ok<AGROW>
    end
    str = str(1:end-2); % strip last \n
    str = wrapInSeparatedBrackets(inputname(1), str);
end

function str = wrapInSeparatedBrackets(lbl, val)
    str = sprintf('<%s>\n%s\n</%s>\n', lbl, val, lbl);
end

function str = wrapInJoinedBrackets(lbl, sublbl, subval, val)
    str = sprintf('<%s %s="%s">\n%s\n</%s>\n', lbl, sublbl, subval, val, lbl);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/struct2str.m] ======  

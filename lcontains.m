function tf = lcontains(tocheck, patt)
%% LCONTAINS does a quick check whether an object (properties, property names)
%            contains a pattern
%   
%  Usage:  tf = lcontains(tocheck, patt) 
%                         ^ string, struct, cell, object
%                                  ^ string
%
%  See Also:  lstrfind, strfind
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/lcontains.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

tf = false;
if (isnumeric(tocheck)); tocheck = num2str(tocheck); end
if (isnumeric(patt));       patt = num2str(patt); end
switch (class(tocheck))
    case 'char'
        tf = lstrfind(tocheck, patt);
    case 'cell'
        for c = 1:length(tocheck) %#ok<*FORFLG>
            tf = lcontains(tocheck{c}, patt);
            if (tf); return; end
        end
    otherwise
        try
            flds = fieldnames(tocheck);
            tf   = lstrfind(flds, patt);
            if (tf); return; end
            
            for f = 1:length(flds)
                tmp = tocheck.(flds{f});
                tf  = any(lcontains(tmp, patt));
                if (tf); return; end
            end          
        catch ME
            handexcept(ME);
        end
end




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/lcontains.m] ======  

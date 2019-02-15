function displine(label, maxWidth, value, valueFrmt)
%% DISPLINE calls fprintf with formatting to match that used by disp    
%  Usage:  displine(label[, maxWidth, value, valueFrmt])
%                   ^       ^         ^      ^
%                   string label or handle to property/method/function
%                           |<--- maxWidth --->|
%                                     value, e.g., string, numeric
%                                            format specifier, e.g., '%s', '[%g %g %g]'
%
%  yields                >>                label: string of values
%
%% Version $Revision: 1209 $ was created $Date: 2011-07-29 15:43:03 -0500 (Fri, 29 Jul 2011) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2011-07-29 15:43:03 -0500 (Fri, 29 Jul 2011) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/displine.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$

    FUNIT         = 1;
    assert(~isempty(label));
    label         = alabel(label);
    if (~exist('maxWidth','var'))
        maxWidth  = 0;
    end
    if ( maxWidth < length(label))
        maxWidth  = length(label) + 2;
    end
    if (~exist('valueFrmt','var') || isempty(valueFrmt))
        switch (class(value))
            case 'char'
                valueFrmt = '%s';
            case numeric_types
                valueFrmt = '';
                if (numel(value) == length(value))
                    for v = 1:length(value) %#ok<*FORPF>
                        valueFrmt = [valueFrmt '%g '];
                    end
                end
            otherwise
                valueFrmt = '';
        end
    end
    if (~isempty(valueFrmt))
        fprintf(FUNIT, ['%' num2str(maxWidth) 's' valueFrmt '\n'],   label, value);
    else
        fprintf(FUNIT, ['%' num2str(maxWidth) 's'           '\n\n'], label); disp(value);
    end

    
    
    function s = alabel(lbl) 

        %% ALABEL pads passed string or function-handle to return a label, right-justified, ending with ': '.
            
        if (isa(lbl, 'function_handle'))
            lbl = func2str(lbl);
        end
        idx     = strfind(    lbl, '.');
        if ( length(idx) > 1)
            idx = idx(1); 
        end
        if (~isempty(idx))
            lbl = strtrim(lbl(idx+1:end)); 
        end
        idx2    = strfind(lbl, '(varargin{:})');
        if ( length(idx2) > 1)
            idx2 = idx2(1); 
        end
        if (~isempty(idx2))
            lbl = strtrim(lbl(1:idx2-1)); 
        end
        s       = sprintf('%s: ', lbl);
    end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/dispformat.m] ======  
end
function str = ensureString(obj, varargin)
    %% ENSURESTRING ensures returned value is a char. string, casting as necessary.
    %  Usage:     string = ensureString(object[, param, value]) 
    %                                            ^ paramters, values for cell2str or struct2str
    %  See also:  cell2str, mlpatterns.List, list2str, struct2str, func2str, num2str
    
    %% Version $Revision: 2369 $ was created $Date: 2013-03-05 06:40:54 -0600 (Tue, 05 Mar 2013) $ by $Author: jjlee $,  
    %% last modified $LastChangedDate: 2013-03-05 06:40:54 -0600 (Tue, 05 Mar 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/ensureString.m $ 
    %% Developed on Matlab 8.0.0.783 (R2012b) 
    %% $Id$ 

    switch (class(obj))
        case 'cell'
            str = cell2str(obj, varargin{:});
        case 'struct'
            str = struct2str(obj, varargin{:});
        case 'char'
            str = strtrim(obj);
        case 'function_handle'
            str = func2str(obj);
        case 'logical'
            if (obj)
                str = 'true';
            else
                str = 'false';
            end
        otherwise
            try
                if (isa(obj, 'mlpatterns.List'))
                    str = list2str(cellObj, varargin{:}); return; end
                if (isempty(obj))
                    str = '[]'; return; end
                if (isnumeric(obj))
                    str = mat2str(obj); return; end
                
                str = char(obj);
            catch ME
                handexcept(ME);
            end
    end
end









% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureString.m] ======  

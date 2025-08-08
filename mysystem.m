function [s,r,str] = mysystem(toeval, varargin)
    %% MYSYSTEM wraps the unix shell or Windows cmd.
    %
    %  Created 23-Nov-2022 11:52:05 by jjlee in repository
    %  /Users/jjlee/MATLAB-Drive/mfiles.
    %  Developed on Matlab 9.13.0.2105380 (R2022b) Update 2 for MACI64.  Copyright 2022 John J. Lee.

    try
        s = 0; r = ''; %#ok<*NASGU>
        switch computer
            case 'GLNXA64'
                if isInParallelWorker()
                    [s,r] = mybash("~/bin/mlenv.sh " + toeval, varargin{:});
                else
                    [s,r] = mybash(toeval, varargin{:});
                end
            case {'MACI64', 'MACA64'}
                [s,r] = myzsh(toeval, varargin{:});
            case 'PCWIN64'
                [s,r] = mycmd(toeval, varargin{:});
            otherwise
                error('mfiles:ValueError', stackstr(3))
        end    
        if (s ~= 0)
            str.toeval = toeval; str.s = s; str.r = r;
            warning('mfiles:ChildProcessWarning', jsonencode(str, PrettyPrint=true));
        end
    catch ME
        handwarning(ME);
        if (s ~= 0)
            str.toeval = toeval; str.s = s; str.r = r;
            warning('mfiles:ChildProcessWarning', jsonencode(str, PrettyPrint=true));
        end
    end
                
    %% INTERNAL

    function [s,r] = mybash(toeval, varargin)
        [s,r] = system(toeval, varargin{:});
    end
    function [s,r] = myzsh(toeval, varargin)
        [s,r] = system(toeval, varargin{:});
    end
    function [s,r] = mycmd(toeval, varargin)
        toeval = strrep(toeval, 'which', 'where');
        [s,r] = system(toeval, varargin{:});
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/mysystem.m] ======  

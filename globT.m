function arow = globT(varargin)
%% GLOBT 
%  @returns cell row-array of globbed files and folders without trailing filesep.
%  Usage:  <folders, files> = globT(<args to glob()>)
%
%% Version $Revision$ was created $Date$ by $Author$,
%% last modified $LastChangedDate$ and checked into repository $URL$,
%% developed on Matlab 9.7.0.1216025 (R2019b) Update 1.  Copyright 2019 John Joowon Lee.

arow = asrow_(glob(varargin{:}));

    function x = asrow_(x)
        x = asrow(x);
        if ~iscell(x) || isempty(x)
            return
        end
        if ~ischar(x{1})
            return
        end
        y = cell(size(x));
        for i = 1:length(x)
            if strcmp(x{i}(end), filesep)
                y{i} = x{i}(1:end-1);
            else
                y{i} = x{i};
            end
        end
        x = y;
    end

end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/globT.m] ======  

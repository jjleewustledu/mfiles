function [ss,select] = pathsplit(pth)
%% PATHSPLIT ...
%  Args:
%      pth isfolder = pwd
%  Returns:
%      ss, e.g., {'fold1', 'fold2', 'fold3'} | ["fold1", "fold2", "fold3"]
%      select logical, non-empty selections from pth
%
%  Created 11-Jul-2023 23:04:44 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.14.0.2286388 (R2023a) Update 3 for MACI64.  Copyright 2023 John J. Lee.

arguments
    pth {mustBeFolder} = pwd
end
ss = strsplit(pth, filesep);
select = cellfun(@(x) ~isempty(x), ss);
ss = ss(select);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/pathsplit.m] ======  

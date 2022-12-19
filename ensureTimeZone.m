function dt = ensureTimeZone(dt)
%% ENSURETIMEZONE ...
%  Args:
%      dt datetime = datetime('now')
%  Returns:
%      dt:  dt with TimeZone
%
%  Created 23-Oct-2022 12:38:28 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.13.0.2080170 (R2022b) Update 1 for MACI64.  Copyright 2022 John J. Lee.

arguments
    dt datetime = datetime('now');
end
if isempty(dt.TimeZone)
    local_ = datetime('now', TimeZone='local');
    dt.TimeZone = local_.TimeZone;
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/ensureTimeZone.m] ======  

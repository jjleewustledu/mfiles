function announce(state_text, tic_time)
%  Args:
%      state_text {istext} = 'begin' : description of state to announce.
%      tic_time uint64 = [] : from tic().
%
%  Created 22-Sep-2022 13:31:04 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.13.0.2049777 (R2022b) for MACI64.  Copyright 2022 John J. Lee.

arguments
    state_text {mustBeText} = 'begin' % description of state to announce.
    tic_time uint64 = [] % from tic().
end

if contains(state_text, 'begin', 'IgnoreCase', true)
    fprintf('Beginning %s.\n', clientname())
    return
end
if contains(state_text, 'end', 'IgnoreCase', true)
    if ~isempty(tic_time)
        fprintf('Ending %s:  ', clientname())
        toc(tic_time)
    end
    fprintf('Ending %s.', clientname())
    return
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/announce.m] ======  

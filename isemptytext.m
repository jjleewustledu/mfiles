function tf = isemptytext(arg)
%% ISEMPTYTEXT assesses whether an object is text && is empty.
%  Args:
%      arg (string|cellstr|char):  text object to assess.
%  Returns:
%      tf:  logical.
%
%  Created 27-Oct-2022 12:24:47 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.13.0.2080170 (R2022b) Update 1 for MACI64.  Copyright 2022 John J. Lee.

if ~istext(arg)
    tf = false;
    return
end

tf = all(arg == "" | isempty(arg));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/isemptytext.m] ======  

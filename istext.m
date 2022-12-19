function tf = istext(arg)
%% ISTEXT assesses whether an object is string, cellstr or char.
%  Args:
%      arg (string|cellstr|char):  text object to assess.
%  Returns:
%      tf:  logical.
%
%  Created 30-Nov-2021 11:04:17 by jjlee in repository /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.11.0.1809720 (R2021b) Update 1 for MACI64.  Copyright 2021 John J. Lee.

tf = isstring(arg) || iscellstr(arg) || ischar(arg);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/istext.m] ======  

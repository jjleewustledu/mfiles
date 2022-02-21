function fn = myniftiname(fn)
%% MYNIFTINAME ...
%  Args:
%      fn (text): arbitrary.
%  Returns:
%      fn: arbitary.nii.gz
%
%  Created 20-Feb-2022 20:23:45 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.11.0.1837725 (R2021b) Update 2 for MACI64.  Copyright 2022 John J. Lee.

fn = strcat(mybasename(fn), '.nii.gz');


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/myniftiname.m] ======  

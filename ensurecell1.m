function c1 = ensurecell1(c)
%% ENSURECELL1 ...
%  Args:
%      c may be cell
%  Returns:
%      c1 <- c{1} if c is cell
%
%  Created 13-Jul-2023 03:20:17 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.14.0.2286388 (R2023a) Update 3 for MACI64.  Copyright 2023 John J. Lee.

if iscell(c)
    c1 = c{1};
    return
end
c1 = c;

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/ensurecell1.m] ======  

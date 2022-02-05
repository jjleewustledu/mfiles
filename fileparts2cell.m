function c = fileparts2cell(fqfn)
%% FILEPARTS2CELL ...
%  Args:
%      fqfilename (text):  understood by myfileparts.
%  Returns:
%      parts:  as cell array.
%
%  Created 03-Feb-2022 12:13:51 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.11.0.1837725 (R2021b) Update 2 for MACI64.  Copyright 2022 John J. Lee.

[p,f,e] = myfileparts(fqfn);
ss = strsplit(p, filesep);
c = [ss {f} {e}];
if isunix
    c = c(2:end);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/fileparts2cell.m] ======  

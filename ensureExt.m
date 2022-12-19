function fn = ensureExt(fn, ext)
%% ENSUREEXT ...
%  Args:
%      fn {mustBeTextScalar} : with or w/o ext
%      ext {mustBeTextScalar} : with or w/o initial '.'
%  Returns:
%      fn : ending in ext, including '.'
%
%  Created 02-Nov-2022 20:27:28 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.13.0.2080170 (R2022b) Update 1 for MACI64.  Copyright 2022 John J. Lee.

arguments
    fn {mustBeTextScalar}
    ext {mustBeTextScalar}
end
if ~startsWith(ext, '.')
    ext = strcat('.', ext);
end

[pth,fp,x] = myfileparts(fn);
if strcmp(x, ext)
    return
end
fn = fullfile(pth, strcat(fp, ext));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/ensureExt.m] ======  

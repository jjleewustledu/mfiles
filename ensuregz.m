function fn_gz = ensuregz(fn)
%% ENSUREGZ ...
%  Args:
%      fn {mustBeFile}:  filename of what must be gzipped.
%  Returns:
%      fn_gq:  filename of gzipped.  Uncompressed file is deleted.
%
%  Created 12-Nov-2022 18:26:02 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.13.0.2080170 (R2022b) Update 1 for MACI64.  Copyright 2022 John J. Lee.

arguments
    fn {mustBeFile}
end

if endsWith(fn, '.gz')
    fn_gz = fn;
    return
end

fn_gz = gzip(fn);
if iscell(fn_gz)
    fn_gz = fn_gz{1};
end
deleteExisting(fn);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/ensuregz.m] ======  

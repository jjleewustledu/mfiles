function dispdbg(obj, opts)
%% DISPDBG ...
%  Args:
%      obj {mustBeNonempty}
%      opts.comments {mustBeTextScalar} = ''
%
%  Created 07-Jan-2023 19:26:15 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.10.0.1851785 (R2021a) Update 6 for MACI64.  Copyright 2023 John J. Lee.

arguments
    obj {mustBeNonempty}
    opts.comments {mustBeTextScalar} = ''
    opts.len_dbs double = 5
end

if isempty(getenv('DEBUG'))
   return
end

dbs = dbstack;
disp('#################################### dispdbg ###########################################')
disp(opts.comments)
disp(obj)
for di = 1:min(length(dbs), opts.len_dbs)
    try
        fprintf('dbstack: %s; line %g\n', dbs(di).name, dbs(di).line);
    catch
        break
    end
end
disp('################################## end dispdbg #########################################')

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/dispdbg.m] ======  

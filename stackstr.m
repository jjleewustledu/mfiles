function rname = stackstr(stack_index, opts)
%% STACKSTR ...
%  Args:
%      stack_index double {mustBeScalarOrEmpty} = 2 : any valid index for dbstack.  
%                                                 3 ~ client of func calling stackstr().
%                                                 2 ~ func calling stackstr(). 
%                                                 1 ~ stackstr(). 
%      opts.use_underscores logical = false : replace {"." "(" ")" "[" "]" "{" "}"} with "_".
%      opts.use_dashes logical = false : replace {"." "(" ")" "[" "]" "{" "}" "_"} with "-".
%  Returns:
%      rname : returned name, e.g., mlpackage_ClientClassName, generated from dbstack()
%
%  Created 02-Nov-2022 21:15:08 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.13.0.2080170 (R2022b) Update 1 for MACI64.  Copyright 2022 John J. Lee.

arguments
    stack_index double {mustBeScalarOrEmpty} = 2
    opts.use_underscores logical = true
    opts.use_dashes logical = false
    opts.use_spaces logical = false
end

try
    dbs = dbstack;
    rname = dbs(min(stack_index, length(dbs))).name;
    if opts.use_underscores
        rname = strrep(rname, '.', '_');
        rname = strrep(rname, '(', '_');
        rname = strrep(rname, ')', '_');
        rname = strrep(rname, '[', '_');
        rname = strrep(rname, ']', '_');
        rname = strrep(rname, '{', '_');
        rname = strrep(rname, '}', '_');
        rname = strrep(rname, '%', '_');
    end
    if opts.use_dashes
        rname = strrep(rname, '.', '-');
        rname = strrep(rname, '(', '-');
        rname = strrep(rname, ')', '-');
        rname = strrep(rname, '[', '-');
        rname = strrep(rname, ']', '-');
        rname = strrep(rname, '{', '-');
        rname = strrep(rname, '}', '-');
        rname = strrep(rname, '%', '-');
        rname = strrep(rname, '_', '-');
    end
    if opts.use_dashes
        rname = strrep(rname, '.', ' ');
        rname = strrep(rname, '(', ' ');
        rname = strrep(rname, ')', ' ');
        rname = strrep(rname, '[', ' ');
        rname = strrep(rname, ']', ' ');
        rname = strrep(rname, '{', ' ');
        rname = strrep(rname, '}', ' ');
        rname = strrep(rname, '%', ' ');
        rname = strrep(rname, '_', ' ');
    end
catch ME
    handwarning(ME);
    rname = 'stackstr';
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/stackstr.m] ======  

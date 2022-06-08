function nm = clientname(varargin)
%% CLIENTNAME is intended for use in logging, generating filenames.
%  Args:
%      use_underscores (logical, option): replace {"." "(" ")" "[" "]" "{" "}"} with "_"; default is false.
%      stack_index (scalar, option): any valid index for dbstack.  
%                                    3 ~ client of func calling clientname(), the default.  
%                                    2 ~ func calling clientname(). 
%                                    1 ~ clientname(). 
%  Returns:
%      returned_name: e.g., mlpackage_ClientClassName, generated from dbstack()
%
%  Created 27-Jan-2022 15:16:39 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.11.0.1837725 (R2021b) Update 2 for MACI64.  Copyright 2022 John J. Lee.

ip = inputParser;
addOptional(ip, 'use_underscores', false, @islogical)
addOptional(ip, 'stack_index', 3, @isscalar)
parse(ip, varargin{:})
ipr = ip.Results;

dbs = dbstack;
nm = dbs(ipr.stack_index).name;
if ipr.use_underscores
    nm = strrep(nm, '.', '_');
    nm = strrep(nm, '(', '_');
    nm = strrep(nm, ')', '_');
    nm = strrep(nm, '[', '_');
    nm = strrep(nm, ']', '_');
    nm = strrep(nm, '{', '_');
    nm = strrep(nm, '}', '_');
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/clientname.m] ======  

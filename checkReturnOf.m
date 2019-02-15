function r = checkReturnOf(s, r)
%% CHECKRETURNOF ... 
%   
%  Usage:  echo_from_bash = checkReturnOf(mlbash_output) 
%          ^ string                       ^ string, first char is a number
%% Version $Revision: 2583 $ was created $Date: 2013-08-29 02:58:59 -0500 (Thu, 29 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-29 02:58:59 -0500 (Thu, 29 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/checkReturnOf.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$

assert(isnumeric(s));
assert(ischar(r));
if (0 ~= s)
    pipe = mlpipeline.PipelineRegistry.instance;
    if (pipe.debugging)
        error('mfiles:mlbashReturnWasAbnormal', 'status ----> %i \nstdout ----> %s \n', s, r);
    end
end




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/mlbashWarning.m] ======  

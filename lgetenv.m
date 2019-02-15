function tf = lgetenv(envvar)
%% LGETENV
%  Usage:  tf = lgetenv(environment_variable) 
%                       ^ string, returned by operating environemnt
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

assert(ischar(envvar));
val = getenv(envvar);
if (strcmpi('true', val) || strcmpi('t', val) || strcmp('1',val))
    tf = true;
else
    tf = false;
end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/lgetenv.m] ======  

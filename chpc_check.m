function [s,r] = chpc_check()
%% CHPC_CHECK ... 
%  Usage:  chpc_check.m() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.341360 (R2016a) 
%% $Id$ 

targ = mlraichle.RaichleRegistry.instance.subjectsDir;
[s,r] = mlbash(['du -h ' targ]);








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/chpc_check.m.m] ======  

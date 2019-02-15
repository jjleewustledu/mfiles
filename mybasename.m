function bn = mybasename(str)
%% MYFILEPREFIX ... 
%  @param str represents any filesystem string.
%  @returns bn is an imaging fileprefix based on str, with removal of path and file extensions known by myfileparts.
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

[~,bn] = myfileparts(str);









% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/mybasename.m] ======  

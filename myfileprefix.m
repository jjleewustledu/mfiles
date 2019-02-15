function fp = myfileprefix(str)
%% MYFILEPREFIX ... 
%  @param str represents any filesystem string.
%  @returns fp is an imaging fileprefix based on str, with removal of file extensions known by myfileparts.
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

[p,f] = myfileparts(str);
fp = fullfile(p, f);






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/myfileprefix.m] ======  

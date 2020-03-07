function f = tempFilepath(f)
%% TEMPFILEPATH ... 
%  Usage:  filepath1 = tempFilepath(filepath) 
%          ^ marked with date and rand
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

[pth,fp] = myfileparts(f);
f = sprintf('%s_%s_rand%g%s', ...
     fullfile(pth, fp), ...
     datestr(now, 30), floor(rand*1e6));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/tempFqfilename.m] ======  

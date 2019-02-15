function fp = tempFileprefix(fp)
%% TEMPFILEPREFIX ... 
%  Usage:  fileprefix1 = tempFileprefix(fileprefix) 
%          ^ marked with date, time and random number
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

[~,fp] = myfileparts(fp);
fp = sprintf('%s_%s_rand%g', ...
     fp, datestr(now, 30), floor(rand*1e6));






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/tempFileprefix.m] ======  

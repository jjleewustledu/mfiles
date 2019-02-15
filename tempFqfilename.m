function fn = tempFqfilename(fn)
%% TEMPFQFILENAME ... 
%  Usage:  filename1 = tempFqfilename(filename) 
%          ^ marked with date and rand
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

[pth,fp,fs] = myfileparts(fn);
fn = sprintf('%s_%s_rand%g%s', ...
     fullfile(pth, fp), ...
     datestr(now, 30), floor(rand*1e6), ...
     fs);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/tempFqfilename.m] ======  

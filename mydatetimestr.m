function s = mydatetimestr(dt)
%% MYDATETIMESTR specifies datestr with a preferred format
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.5.0.1049112 (R2018b) Update 3.  Copyright 2019 John Joowon Lee. 

s = sprintf('DT%s000', datestr(dt, 'yyyymmddHHMMSS.FFF'));








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/datetimestr.m] ======  

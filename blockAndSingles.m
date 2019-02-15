function [b,s] = blockAndSingles(p)
%% BLOCKANDSINGLES ... 
%  Usage:  blockAndSingles() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.2.0.538062 (R2017a).  Copyright 2017 John Joowon Lee. 
b = bitand(bitshift(p, -19, 'uint32'), 1023, 'uint32');
s = bitand(p, 524287, 'uint32');








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/blockAndSingles.m] ======  

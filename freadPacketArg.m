function pac = freadPacketArg(fid, nlook)
%% FREEDPACKET ... 
%  Usage:  freedPacket() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.2.0.538062 (R2017a).  Copyright 2017 John Joowon Lee. 
pac = fread(fid, nlook, 'uint32=>uint32');

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/freedPacket.m] ======  

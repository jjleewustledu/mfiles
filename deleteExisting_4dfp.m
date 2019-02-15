function deleteExisting_4dfp(arg)
%% DELETEEXISTING_4DFP ... 
%  Usage:  deleteExisting_4dfp() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.1.0.441655 (R2016b).  Copyright 2018 John Joowon Lee. 

suffs = {'.4dfp.hdr' '.4dfp.ifh' '.4dfp.img' '.4dfp.img.rec'};

arg = myfileprefix(arg);
for s = 1:length(suffs)
    deleteExisting([arg suffs{s}]);
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/deleteExisting_4dfp.m] ======  

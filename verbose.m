function tf = verbose()
%% VERBOSE
%  @return tf := getenv('VERBOSE') is non-empty || getenv('VERBOSITY') is non-empty.
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.1.0.441655 (R2016b).  Copyright 2018 John Joowon Lee. 

tf = ~isempty(getenv('VERBOSE')) || ~isempty(getenv('VERBOSITY'));







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/verbose.m] ======  


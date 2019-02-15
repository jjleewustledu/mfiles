function str = upperFirst(str)
%% UPPERFIRST capitalizes the first character of a string
%  Usage:  str = upperFirst(str) 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

assert(~isempty(str));
str = [upper(str(1)) lower(str(2:end))];








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/upperFirst.m] ======  

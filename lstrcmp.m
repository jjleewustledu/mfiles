function tf = lstrcmp(str, str1)
%% LSTRCMP ... 
%  Usage:  tf = lstrcmp(str, str1) 
%          ^ bool       ^    ^ char or cell-array of char
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.341360 (R2016a) 
%% $Id$ 

tf = strcmp(str, str1);
while (numel(tf) > 1)
    tf = any(tf);
end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/lstrcmp.m] ======  

function str = caplower(str)
%% CAPLOWER capitalizes the first letter only of a string; lowers remaining letters.

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

assert( ischar(str));
assert(~isempty(str));
str = [upper(str(1)) lower(str(2:end))];









% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/capitalize.m] ======  

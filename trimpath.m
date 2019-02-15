function pth = trimpath(pth)
%% TRIMPATH strips trailing '/' from a path-string
%  Usage:  trimmed_path = trimpath(path) 
%          ^                       ^ strings

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

assert(ischar(pth));
if (strcmp('/', pth(end)))
    pth = pth(1:end-1); end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/trimpath.m] ======  

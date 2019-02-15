function str = capitalize(str)
%% CAPITALIZE capitalizes the first letter only of a string 

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

assert( ischar(str));
if (isempty(str))
    return
end
str = [upper(str(1)) str(2:end)];









% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/capitalize.m] ======  

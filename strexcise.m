function s = strexcise(s, subs)
    %% STREXCISE removes occurences of substring in string/char s.
    %  Usage:  s = strexcise(s, substring) 
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository $URL$,  
    %% developed on Matlab 9.5.0.944444 (R2018b).  Copyright 2018 John Joowon Lee. 

    split = strsplit(s, subs);
    s = strcat(split{:});

end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/strexcise.m] ======  

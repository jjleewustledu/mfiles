function dt = ensureDatetime(dt)
%% ENSUREDATETIME ... 
%  Usage:  ensureDatetime() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

if (~isdatetime(dt))
    try
        dt = datetime(dt);
    catch ME
        dispexcept(ME);
    end
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/ensureDatetime.m] ======  

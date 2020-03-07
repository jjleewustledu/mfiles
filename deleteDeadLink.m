function deleteDeadLink(lnk)
%% DELETEDEADLINK ... 
%  Usage:  deleteDeadLink(link_filename) 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.6.0.1135713 (R2019a) Update 3.  Copyright 2019 John Joowon Lee. 

assert(ischar(lnk))
r = '';

for g = asrow(glob(lnk))
    try
        [~,r] = system(sprintf('rm -f %s', g{1}));
    catch ME
        disp(r)
        handwarning(ME)
    end
end




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/deleteDeadLink.m] ======  

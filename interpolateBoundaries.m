function [t1,A1,t2,A2] = interpolateBoundaries(t1, A1, t2, A2)
    %% INTERPOLATEBOUNDARIES 
    %  @return prepends or appends time and concentration datapoints to manage boundaries prior to invoking
    %  pchip.  The first or last times and concentrations are repeated as needed to extend array boundaries.
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository $URL$,  
    %% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2017 John Joowon Lee. 

    if (t1(1) < t2(1))
        t2    = [t1(1)    t2];
        A2 = [A2(1) A2];
    end
    if (t1(1) > t2(1))                
        t1    = [t2(1)    t1];
        A1 = [A1(1) A1];
    end
    if (t1(end) < t2(end))
        t1 =    [t1    t2(end)];
        A1 = [A1 A1(end)];
    end
    if (t1(end) > t2(end))
        t2 =    [t2    t1(end)];
        A2 = [A2 A2(end)];
    end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/interpolateBoundaries.m] ======  

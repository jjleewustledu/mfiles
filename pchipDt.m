function A = pchipDt(t, A, t_, Dt)
    %% PCHIPDT slides discretized function A(t) to A(t_ - Dt);
    %  @param t  is the initial t sampling
    %  @param A  is the initial A sampling
    %  @param t_ is the final   t sampling
    %  @param Dt is the shift of t_
    %  @param Dt > 0 will slide conc(t) towards to later values of t.
    %  @param Dt < 0 will slide conc(t) towards to earlier values of t.
    %  It works for inhomogeneous t according to the ability of pchip to interpolate.
    %  It may not preserve information according to the Nyquist-Shannon theorem.  
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository $URL$,  
    %% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2017 John Joowon Lee. 

    tspan = t(end) - t(1);
    dt    = t(2) - t(1);
    t     = [(t - tspan - dt) t]; % prepend times
    A     = [zeros(size(A)) A]; % prepend zeros
    A     = pchip(t, A, t_ - Dt); % interpolate onto t shifted by Dt; Dt > 0 shifts conc to right

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/pchipDt.m] ======  

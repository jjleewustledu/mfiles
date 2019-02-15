function conc = slideDt(conc, t, Dt)
    %% SLIDE slides discretized function conc(t) to conc(t - Dt);
    %  @param Dt > 0 will slide conc(t) towards later times t.
    %  @param Dt < 0 will slide conc(t) towards earlier times t.
    %  It works for inhomogeneous t according to the ability of pchip to interpolate.
    %  It may not preserve information according to the Nyquist-Shannon theorem.  
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository $URL$,  
    %% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2017 John Joowon Lee. 
            
    import mlbayesian.*;
    [conc,trans] = AbstractBayesianStrategy.ensureRow(conc);
    t            = AbstractBayesianStrategy.ensureRow(t);

    tspan = t(end) - t(1);
    tinc  = t(2) - t(1);
    t_    = [(t - tspan - tinc) t];   % prepend times
    conc_ = [zeros(size(conc)) conc]; % prepend zeros
    conc_(isnan(conc_)) = 0;
    conc  = pchip(t_, conc_, t - Dt); % interpolate onto t shifted by Dt; Dt > 0 shifts to right

    if (trans)
        conc = conc';
    end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/slideDt.m] ======  

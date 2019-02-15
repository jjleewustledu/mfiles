function Dt = timeSeriesDt(aifTimes, aifActivity, scannerTimes, scannerActivity)
    %% TIMESERIESDT
    %  @return Dt > 0 if aif bolus peak follows  the scanner bolus peak
    %  @return Dt < 0 if aif bolus peak precedes the scanner bolus peak
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository $URL$,  
    %% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2017 John Joowon Lee. 

    eps_ = 0.01;
    [~,idxMaxAif]       = max(aifActivity);
    [~,idxMaxScanner]   = max(scannerActivity);
    aifFront            = aifActivity(1:idxMaxAif);
    scannerFront        = scannerActivity(1:idxMaxScanner);
    [~,idxStartAif]     = max(aifFront > eps_*max(aifFront));
    [~,idxStartScanner] = max(scannerFront > eps_*max(scannerFront));

    Dt = aifTimes(idxStartAif) - scannerTimes(idxStartScanner);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/timeSeriesDt.m] ======  

function ss = ttestSurfer(vec, mskL, mskR)
    %% TTESTSURFER ... 
    %   
    %  Usage:  statstruct = ttestSurfer(vec, mskL, mskR)
    %          ^ 

    %% Version $Revision: 2473 $ was created $Date: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ by $Author: jjlee $,  
    %% last modified $LastChangedDate: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/ttestSurfer.m $ 
    %% Developed on Matlab 8.1.0.604 (R2013a) 
    %% $Id$ 
    assert(length(vec) == length(mskL));
    assert(length(vec) == length(mskR));
    assert(all(isfinite(vec)));
    assertRange(mskL, [0 1]);
    assertRange(mskR, [0 1]);
    smallerLen = min(length(vec(mskL)), length(vec(mskR)));
    vecL = vec(mskL);
    vecR = vec(mskR);
    vecL = vecL(1:smallerLen);
    vecR = vecR(1:smallerLen);

    diff = vecR - vecL;
    [ss.hypothesis, ss.pvalue, ss.ci, ss.stats] = ttest(diff);

    function assertRange(vec, rng)
        assert(rng(1) == min(vec));
        assert(rng(2) == max(vec));
    end




end % function ttestSurfer

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ttestDifference.m] ======  

%CUTOFFVALUES

function dbleCoord = cutoffValues(dbleCoord, kindImg, moment)

    NULL_VALUE = -10;
    MAX_HO1    = 100;
    MAX_F      = 10;
    MAX_MLEM   = 10;

    if dbleCoord < eps, 
        dbleCoord = NULL_VALUE; return; end
    if strcmp('ho1',     kindImg) & 1 == moment & dbleCoord > MAX_HO1,  
        dbleCoord = NULL_VALUE; return; end
    if strcmp('F',       kindImg) & 1 == moment & dbleCoord > MAX_F,    
        dbleCoord = NULL_VALUE; return; end
    if strcmp('cbfMlem', kindImg) & 1 == moment & dbleCoord > MAX_MLEM, 
        dbleCoord = NULL_VALUE; return; end

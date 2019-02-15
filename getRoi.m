%GETROI
%
% Usage:  anRoi = getRoi(p, kindRoi, side, rIdx, sIdx, NSIDE, theRois)
% 
% See also:  roiContraLesion(), roiIpsiLesion()
%_____________________________________________________________________

function anRoi = getRoi(p, kindRoi, side, rIdx, sIdx, NSIDE, theRois)

DEBUG = 1;

grey  = theRois{1};
basal = theRois{2};
white = theRois{3};

switch (rIdx)
    case 1
        anRoi = grey;
    case 2
        anRoi = basal;
    case 3
        anRoi = white;
    otherwise
        error(['getRoi.r -> ' num2str(rIdx) ' was not recognizable']);
end

switch (sIdx)
    case 1
        sideRoi = roiContraLesion(p);
    case 2
        sideRoi = roiIpsiLesion(p);
    otherwise
        error(['getRoi.s -> ' num2str(sIdx) ' was not recognizable']);
end

if DEBUG
    disp(['size(sideRoi) -> ' num2str(size(sideRoi))]);
    disp(['size(anRoi)   -> ' num2str(size(anRoi))]);
end
anRoi = anRoi.*sideRoi;


%GETPERMUTEDROI
%
% Usage:  anRoi = getRoi(p, kindRoi, side, rIdx, sIdx, NSIDE, theRois)
% 
% See also:  roiContraLesion(), roiIpsiLesion()
%_____________________________________________________________________

function anRoi = getPermutedRoi(p, kindRoi, side, rIdx, sIdx, NSIDE, theRois)

DEBUG = 0;

grey  = theRois{1};
basal = theRois{2};
white = theRois{3};

if (strcmp('allrois', kindRoi))
    switch (rIdx)
        case 1
            anRoi = grey;
        case 2
            anRoi = basal;
        case 3
            anRoi = white;
        otherwise
            error(['peekCoords.r -> ' num2str(rIdx) ' was not recognizable']);
    end
else
    switch (kindRoi)
        case 'grey'
            anRoi = grey;
        case 'basal'
            anRoi = basal;
        case 'white'
            anRoi = white;
        case 'union'
            anRoi = grey || basal || white;
        otherwise
            error(['getRoi.kindRoi -> ' kindRoi ' was not recognizable']);
    end
end

sideRoi = newim(anRoi);
if (NSIDE == 1)
    switch (side)
        case 'ipsi'
            sideRoi = roiIpsiLesion(p);
        case 'contra'
            sideRoi = roiContraLesion(p);
        case 'union'
            sideRoi = roiIpsiLesion(p) || roiContraLesion(p);
    end
else
    switch (sIdx)
        case 1
            sideRoi = roiContraLesion(p);
        case 2
            sideRoi = roiIpsiLesion(p);
        otherwise
    end
end

if DEBUG
    disp(['size(sideRoi) -> ' num2str(size(sideRoi))]);
    disp(['size(anRoi)   -> ' num2str(size(anRoi))]);
end
anRoi = anRoi.*sideRoi;


%PEEKINDICES
%
% Usage:  theCoords = peekIndices(kindRoi, kindImg, side, moment)
%
%         theCoords will be a vector of doubles, ordered ascending
%         kindRoi is 'grey', 'basal', 'white' or 'allrois'
%         kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd', 'cbv...', 'mtt...' or 'ho1' 
%         side    is 'ipsi', 'contra' -lateral to lesions, otherwise both sides
%         moment  is 0 (pop), 1 (mean) or 2 (stderr)
%
% See also:  peekPerfusion, getSliceMask, getRoi
%
% 8/27/2007 - Version 3 Change Log 
% -- tries to work with cbv & mtt (needs testing)
% -- checks number of args and processes accordingly
% -- still has kludge for incomplete patient/subject data
% -- uses function peekPerfusion(,,), delegating processing of roiKind
%    and checks of double & dipimage and checks for NaNs
% -- uses function getRoi(,,,,,,), delegating processing of kindRoi
%________________________________________________________________

function theCoords = peekIndices(kindRoi, kindImg, side, moment)

switch (nargin)
    case {0,1}
        disp('peekCoords3(...) requires at least kindRoi and kindImg as args.');
        error(help('peekCoords3'));
    case 2
        side = 'both';
        moment = 1;
    case 3
        moment = 1;
    case 4
    otherwise
        error(help('peekCoords3'));
end

NPID = 19;
if (strcmp('allrois', kindRoi)) 
    NROI = 3; 
else
    NROI = 1;
end
if (strcmp('ipsi', side) || strcmp('contra', side))
  NSIDE = 1;
else
  NSIDE = 2;
end
    
    

% gather ROIs, image data, and truncate ROIs by available slices

theCoords = -1 .* ones(NPID*NROI*NSIDE,1);

for p = 1:NPID
    
    if (pidToExclude(p, kindImg)) 
        for r = 1:NROI
            for s = 1:NSIDE
                idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;
                theCoords(idx) = -1.0;
            end
        end
        continue; 
    end

	[grey, basal, white, allRois] = peekRois(p, kindRoi, 'dip', 0, excludeCsfRoi(kindImg));
    theRois = { grey, basal, white };
	
    for r = 1:NROI 
        for s = 1:NSIDE        
            idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;
            anRoi = getRoi(p, kindRoi, side, r, s, NSIDE, theRois);
            disp(['pid -> ' num2str(p) ' roi -> ' num2str(r) ' side -> ' num2str(s) ' N_voxels -> ' num2str(sum(anRoi))]);
			theCoords(idx) = peekDoubleCoord(anRoi, anRoi, moment);
        end
    end
end


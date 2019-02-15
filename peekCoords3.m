%PEEKCOORDS
%
% Usage:  theCoords = peekCoords3(kindRoi, kindImg, side, moment, white_matter_ref)
%
%         theCoords will be a vector of doubles, ordered ascending
%         kindRoi is 'grey', 'basal', 'white' or 'allrois'
%         kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd', 'cbv...', 'mtt...' or 'ho1' 
%         side    is 'ipsi', 'contra' -lateral to lesions, otherwise both sides
%         moment  is 0 (pop), 1 (mean) or 2 (stderr)
%         white_matter_ref is 0 or 1 (optional)
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

function theCoords = peekCoords3(kindRoi, kindImg, side, moment, white_matter_ref)

switch (nargin)
    case {0,1}
        disp('peekCoords3(...) requires at least kindRoi and kindImg as args.');
        error(help('peekCoords3'));
    case 2
        side = 'both';
        moment = 1;
        white_matter_ref = 0;
    case 3
        moment = 1;
        white_matter_ref = 0;
    case 4
        white_matter_ref = 0;
    case 5
    otherwise
        error(help('peekCoords3'));
end

REFVAL = 22;  % ref. CBF for white matter
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
                disp(['excluding pid -> ' num2str(p) ', roi -> ' num2str(r) ', side -> ' num2str(s)]);
            end
        end
        continue; 
    end
    
    [grey, basal, white, allRois] = peekRois(p, kindRoi);
    theRois = { grey, basal, white };

    if ~isnumeric(grey),    error(['grey{'    num2str(p) '} was not numeric']); end
    if ~isnumeric(basal),   error(['basal{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(white),   error(['white{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(allRois), error(['allRois{' num2str(p) '} was not numeric']); end

    grey    = grey    .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
    basal   = basal   .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
    white   = white   .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
    allRois = allRois .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));

    theImg = peekPerfusion(p, kindImg);
    if ~isnumeric(theImg), 
        error(['theImg->' kindImg ' for pid->' pidList(p) ' was not numeric']); end

%	if (strcmp('ho1', kindImg))
%		theImg = counts_to_petCbf(theImg, p);
%	end
	
    if white_matter_ref
        r = 3;
        for s = 1:NSIDE        
            idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;
            anRoi = getRoi(p, kindRoi, side, r, s, NSIDE, theRois);

            switch moment
                case 0
                    theCoords(idx) = peekDoubleCoord(anRoi, theImg, 0);
                case 1
                    theCoords(idx) = REFVAL;
                otherwise
                    theCoords(idx) = 0;
            end
        end
    end
 
    for r = 1:NROI
        for s = 1:NSIDE        
            idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;
            anRoi = getRoi(p, kindRoi, side, r, s, NSIDE, theRois);

            theCoords(idx) = peekDoubleCoord(anRoi, theImg, moment, p);
            if (strcmp('ho1', kindImg) && moment > 0)
                theCoords(idx) = counts_to_petCbf(theCoords(idx), p);
            end
        end
    end 
    
    if (white_matter_ref)
        switch moment
            case 1
                for s = 1:NSIDE        
                    idx_grey  = (p - 1)*NROI*NSIDE + s;
                    idx_basal = (p - 1)*NROI*NSIDE + NSIDE + s;
                    idx_white = (p - 1)*NROI*NSIDE + 2*NSIDE + s;

                    theCoords(idx_grey)  = REFVAL*theCoords(idx_grey)/theCoords(idx_white);
                    theCoords(idx_basal) = REFVAL*theCoords(idx_basal)/theCoords(idx_white);
                    theCoords(idx_white) = REFVAL;
                end
            case 2
                for s = 1:NSIDE        
                    idx_grey  = (p - 1)*NROI*NSIDE + s;
                    idx_basal = (p - 1)*NROI*NSIDE + NSIDE + s;
                    idx_white = (p - 1)*NROI*NSIDE + 2*NSIDE + s;

                    theCoords(idx_grey)  = REFVAL*theCoords(idx_grey)/theCoords(idx_white);
                    theCoords(idx_basal) = REFVAL*theCoords(idx_basal)/theCoords(idx_white);
                    theCoords(idx_white) = 0;
                end
            otherwise
        end
    end
    
end


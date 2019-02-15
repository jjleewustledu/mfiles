%PEEKCOORDS5
%
% Usage:  theValues = peekCoords5(kindRoi, kindImg, side, moment, ref_tissue, blur)
%
%         theValues will be a vector of doubles, one for each pid
%         kindRoi    is 'grey', 'basal', 'white' or 'allrois'
%         kindImg    is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd', 'cbv...', 'mtt...' or 'ho1' 
%         side       is 'ipsi', 'contra' -lateral to lesions, otherwise both sides
%         moment     is 0 (pop), 1 (mean) or 2 (stderr)
%         ref_tissue is boolean, 0 or 1 (optional)
%         blur       is boolean, 0 or 1 (optional)
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

function theValues = peekCoords5(kindRoi, kindImg, side, moment, ref_tissue, blur)

switch (nargin)
    case {0,1}
        disp('peekCoords5(...) requires at least kindRoi and kindImg as args.');
        error(help('peekCoords5'));
    case 2
        side = 'both';
        moment = 1;
        ref_tissue = 0;
        blur = 0;
    case 3
        moment = 1;
        ref_tissue = 0;
        blur = 0;
    case 4
        ref_tissue = 0;
        blur = 0;
    case 5
        ref_tissue = ref_tissue && moment ~= 0;
        blur = 0;
    otherwise
        error(help('peekCoords5'));
end

switch (moment)
    case 0
        refValue = 0;
    case 1
        refValue = 22;  % ref. CBF for white matter
    case 2
        refValue = 22;
    case 22
        refValue = 22;
    otherwise
        error(['Sorry, peekCoord5 does not currently handle moment -> ' num2str(moment)]);
end

DIMX         = 256;
DIMY         = 256;
DIMZ         = 8;
GREY_ROI     = 1;
BASAL_ROI    = 2;
WHITE_ROI    = 3;
REF_ROI      = WHITE_ROI;
KIND_REF_ROI = 'white';
NPID         = 19;
excludeCsf = strcmp('ho1', kindImg);
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

theValues = -1 .* ones(NPID,1);
if ref_tissue, refRawValues = -1 .* ones(NPID,1); end
	
extendRoi = -1.*ones(DIMX,DIMY,DIMZ,NROI,NSIDE);
extendImg = -1.*ones(DIMX,DIMY,DIMZ,NROI,NSIDE);

for p = 1:NPID
    
    if (pidToExclude(p, kindImg)) 
        theValues(p) = -1.0;
        disp(['excluding pid -> ' num2str(p) ', roi -> ' num2str(r) ', side -> ' num2str(s)]);
        continue; 
    end
    
    [grey, basal, white, allRois] = peekRois(p, kindRoi, 'dip', 0, excludeCsf);
    theRois = { grey, basal, white };

    theImg = squeeze(peekPerfusion(p, kindImg, 0, [0,0], 'dip'));
    if blur,
        theImg = gaussAnisof(theImg, [4.2553 4.2553 0.6649]); end % 10 mm fwhh blur in all directions 
    
	for r = 1:NROI
        for s = 1:NSIDE
            positivityMask = (theImg > 0);
            theImg = positivityMask .* theImg;
			extendImg(:,:,:,r,s) = theImg;
		end
	end
    if ~strcmp('dip_image', class(extendImg)), 
        error(['extendImg->' kindImg ' for pid->' pidList(p) ' was not numeric']); end

%	if (strcmp('ho1', kindImg))
%		extendImg = counts_to_petCbf(extendImg, p);
%	end
 
    for r = 1:NROI
        for s = 1:NSIDE 
            extendRoi(:,:,:,r,s) = getPermutedRoi(p, kindRoi, side, r, s, NSIDE, theRois);
        end
    end 

	if (~ref_tissue)
		theValues(p) = peekDoubleCoord(extendRoi, extendImg, moment);
	else
        refRoi       = peekRefRois(p, KIND_REF_ROI);
	    refRawValues = -1.*ones(NROI,NSIDE);
	    roiRawValues = -1.*ones(NROI,NSIDE);
        for s = 1:NSIDE        
            % using only white-matter ref.       
            refRawValues(WHITE_ROI,s) = peekDoubleCoord(refRoi, extendImg(:,:,:,WHITE_ROI,s), 1); 
            refRawValues(BASAL_ROI,s) = refRawValues(WHITE_ROI,s);
            refRawValues(GREY_ROI,s)  = refRawValues(WHITE_ROI,s);            
        end
		for r = 1:NROI
			for s = 1:NSIDE
				roiRawValues(p,r,s)   = peekDoubleCoord(extendRoi(:,:,:,r,s),  extendImg(:,:,:,r,s),  moment);
			end
		end
		tmp1 = 0;
        for s = 1:NSIDE   
            tmp1 = tmp1 + refValue*roiRawValues(p,GREY_ROI,s)/refRawValues(GREY_ROI,s) + ...
                          refValue*roiRawValues(p,BASAL_ROI,s)/refRawValues(BASAL_ROI,s) + ...
                          refValue*roiRawValues(p,WHITE_ROI,s)/refRawValues(WHITE_ROI,s);
        end
		theValues(p) = tmp1/NSIDE/NROI;
    end

	if (strcmp('ho1', kindImg) && moment > 0)
        theValues(p) = counts_to_petCbf(theValues(p), p);
    end
    
end


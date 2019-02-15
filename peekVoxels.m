% PEEKVOXELS
%
% Usage:  theValues = peekVoxels(pid, kindImg, kindRoi, side, tiss_ref, fwhh)
%
%         theValues will be a vector of doubles, one for each pid
%         kindRoi  is 'grey', 'basal', 'white' or 'allrois'
%         kindImg  is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd', 'cbv...', 'mtt...' or 'ho1' 
%         side     is 'ipsi', 'contra' -lateral to lesions, otherwise both sides
%         blur     is boolean, 0 or 1
%         tiss_ref is boolean, 0 or 1
%         fwhh     is for 3D-Gaussian blurring
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

function [theValues, extendRoi, extendImg] = peekVoxels(pid, kindImg, kindRoi, side, blur, tiss_ref, fwhh)

    DIMX         = 256;
	DIMY         = 256;
	DIMZ         = 8;
	GREY_ROI     = 1;
	BASAL_ROI    = 2;
	WHITE_ROI    = 3;
	NPID         = 19;
    
    [pid, p] = ensurePid(pid);
    
	switch (nargin)
	    case {0,1}
	        disp('peekVoxels(...) requires at least pid and kindImg as args.');
	        error(help('peekVoxels'));
        case 2
            kindRoi = 'allrois';
            side = 'both';
            blur = 0;
            tiss_ref = 0;
	    case 3
            side = 'both';
            blur = 0;
            tiss_ref = 0;
	    case 4
            blur = 0;
            tiss_ref = 0;
        case 5
            tiss_ref = 0;
        case 6
            if blur, fwhh = db('fwhh blur for PET'); end
        case 7
	    otherwise
	        error(help('peekVoxels'));
    end

	amplitude = 10;
	switch (kindImg)
	    case 'F'
	    case 'cbfMlem'
	    case 'ho1'
			amplitude = 100;
	    otherwise
	        error(['Sorry, peekVoxels did not recognize kindImg -> ' kindImg]);
    end

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
    
    [grey, basal, white, allRois] = peekRois(pid, 'allrois', 'dip', 0, excludeCsfRoi(kindImg));
    theRois = { grey, basal, white };
    extendRoi = newim(DIMX,DIMY,DIMZ);
    for r = 1:NROI
        for s = 1:NSIDE 
            extendRoi = extendRoi | getPermutedRoi(pid, kindRoi, side, r, s, NSIDE, theRois); 
        end
    end 

    extendImg = squeeze(peekPerfusion(pid, kindImg, 0, [0, 0], 'dip'));
    extendImg = extendRoi .* extendImg;
    if (blur)
        extendImg = gaussAnisof(extendImg, mlfourd.NiiBrowser.width2sigma(fwhh)); 
	end % 10 mm fwhh blur isotropic  
    if (tiss_ref)
        % using only white-matter ref.
        refValue = 22; 
        refRawValues = peekDoubleCoord(peekRefRois(p), extendImg, 1, p, kindImg);  
        extendImg = (refValue/refRawValues) * extendImg;
    end
    
	theValues = peekDoubleVoxels(extendRoi, extendImg);
	if strcmp('ho1', kindImg),
        theValues = counts_to_petCbf(theValues, pid); end



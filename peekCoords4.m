%PEEKCOORDS4
%
% Usage:  theValues = peekCoords4(kindRoi, kindImg, side, moment, ref_tissue, blur, fwhh)
%
%         theValues will be a vector of doubles, ordered ascending
%         kindRoi is 'grey', 'basal', 'white', 'allrois', 'union'
%         kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd', 'cbv...', 'mtt...' or 'ho1' 
%         side    is 'ipsi', 'contra' -lateral to lesions, otherwise both
%                     sides, or 'union'
%         moment  is 0 (pop), 1 (mean) or 2 (stderr)
%         ref_tissue is boolean, 0 or 1 (optional)
%         blur       is boolean, 0 or 1 (optional)
%         fwhh       is mm (optional)
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
%
% 9/26/2007 - Version 4 Change Log
% -- Uses white matter ROIs specially selected to represent normal tissues
%    which are most likely to have blood flow ~ 22 mL/min/100 g
% -- Still lists theValues in loops of pid - ROI-type - ipsilateral/contralateral
%________________________________________________________________

function theValues = peekCoords4(kindRoi, kindImg, side, moment, ref_tissue, blur, fwhh)

    switch (nargin)
        case {0,1}
            disp('peekCoords4(...) requires at least kindRoi and kindImg as args.');
            error(help('peekCoords3'));
        case 2
            side = 'both';
            moment = 1;
            ref_tissue = 0;
            blur = 0;
            fwhh = 4.4;
        case 3
            moment = 1;
            ref_tissue = 0;
            blur = 0;
            fwhh = 4.4;
        case 4
            ref_tissue = 0;
            blur = 0;
            fwhh = 4.4;
        case 5
            blur = 0;
            fwhh = 4.4;
        case 6
            if blur ~= 1,
                fwhh = blur; end
            fwhh = 4.4;
        case 7
        otherwise
            error(help('peekCoords4'));
    end
    
    if strcmp('all', kindRoi),
        kindRoi = 'allrois'; end
    if strcmp('mlemCbf', kindImg) | strcmp('Fmlem', kindImg) | strcmp('mlemF', kindImg),
        kindImg = 'cbfMlem'; end
    if strcmp('osvdCbf', kindImg) | strcmp('Fosvd', kindImg) | strcmp('osvdF', kindImg),
        kindImg = 'cbfMlem'; end
    if strcmp('ssvdCbf', kindImg) | strcmp('Fssvd', kindImg) | strcmp('ssvdF', kindImg),
        kindImg = 'cbfMlem'; end
    if strcmp('svdCbf', kindImg)  | strcmp('Fsvd',  kindImg) | strcmp('svdF',  kindImg),
        kindImg = 'cbfMlem'; end
    excludeCsf = ~strcmp('ho1', kindImg);

    switch (moment)
        case 0
            refValue = 0;
        case 1
            refValue = 22;  % ref. CBF for white matter
        case 2
            refValue = 22;
        otherwise
            error(['Sorry, peekCoord4 does not currently handle moment -> ' num2str(moment)]);
    end

    ref_tissue = ref_tissue && moment ~= 0 && strcmp('cbfMlem', kindImg);

    IMG_MIN      = -10;
    GREY_ROI     = 1;
    BASAL_ROI    = 2;
    WHITE_ROI    = 3;
    REF_ROI      = WHITE_ROI;
    KIND_REF_ROI = 'white';
    NPID         = 19;
    if (strcmp('allrois', kindRoi)) 
        NROI = 3; 
    else
        NROI = 1;
    end
    if (strcmp('ipsi', side) || strcmp('contra', side) || strcmp('union', side))
      NSIDE = 1;
    else
      NSIDE = 2;
    end
    XY_MMPIXEL = 0.9375;
    Z_MMPIXEL = 6.0;



    % gather ROIs, image data, and truncate ROIs by available slices

    theValues = -10 .* ones(NPID*NROI*NSIDE,1);
    if ref_tissue, refRawValues = -10 .* ones(NPID*NROI*NSIDE,1); end

    for p = 1:NPID

        if (pidToExclude(p, kindImg)) 
            for r = 1:NROI
                for s = 1:NSIDE
                    idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;
                    theValues(idx) = -10;
                    disp(['excluding pid -> ' num2str(p) ', roi -> ' num2str(r) ', side -> ' num2str(s)]);
                end
            end
            continue; 
        end

        [grey, basal, white, allRois] = peekRois(p, kindRoi, 'dip', 0, excludeCsf);
        theRois = { grey, basal, white };
        unionRois = grey || basal || white;

        if ~isnumeric(grey),    error(['grey{'    num2str(p) '} was not numeric']); end
        if ~isnumeric(basal),   error(['basal{'   num2str(p) '} was not numeric']); end
        if ~isnumeric(white),   error(['white{'   num2str(p) '} was not numeric']); end
        if ~isnumeric(allRois), error(['allRois{' num2str(p) '} was not numeric']); end
        if ~isnumeric(unionRois), error(['allRois{' num2str(p) '} was not numeric']); end

        grey    = grey    .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
        basal   = basal   .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
        white   = white   .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
        allRois = allRois .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
        unionRois = unionRois .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
        theImg  = squeeze(peekPerfusion(p, kindImg, 0, [0,0], 'dip'));
        
        blurredImg = newim(theImg);
        for r = 1:NROI
            for s = 1:NSIDE        
                idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;
                if (blur)
					sigmas = [fwhh/(2*XY_MMPIXEL) fwhh/(2*XY_MMPIXEL) fwhh/(2*Z_MMPIXEL)];
                    blurredImg = gaussAnisof(theImg, sigmas); 
				end % (fwhh/mm)/(2 mm/pixel) -> pixels; isotropic blur 
                    
                anRoi = getPermutedRoi(p, kindRoi, side, r, s, NSIDE, theRois);
                cutImg = anRoi .* theImg;
                theValues(idx) = peekDoubleCoord(anRoi, theImg, moment, p, kindImg);
                if (strcmp('ho1', kindImg) && moment > 0)
                    theValues(idx) = counts_to_petCbf(theValues(idx), p);
                end
            end
        end 

        if (~ref_tissue)
            for i = 1:size(theValues,1)
                theValues(i) = cutoffValues(theValues(i), kindImg, moment);
            end
        end

        if (ref_tissue)
            for s = 1:NSIDE        
                idx_grey  = (p - 1)*NROI*NSIDE + (GREY_ROI  - 1)*NSIDE + s;
                idx_basal = (p - 1)*NROI*NSIDE + (BASAL_ROI - 1)*NSIDE + s;
                idx_white = (p - 1)*NROI*NSIDE + (WHITE_ROI - 1)*NSIDE + s;

                % using only white-matter ref.
                refRoi = peekRefRois(p); %%% getPermutedRoi(p, KIND_REF_ROI, side, WHITE_ROI, s, NSIDE, theRois); 
                cutImg = (theImg > IMG_MIN) .* blurredImg;

                refRawValues(idx_white) = peekDoubleCoord(refRoi, blurredImg, moment, p, kindImg); 
                refRawValues(idx_basal) = refRawValues(idx_white);
                refRawValues(idx_grey)  = refRawValues(idx_white);

            end
            for s = 1:NSIDE        
                idx_grey  = (p - 1)*NROI*NSIDE + (GREY_ROI  - 1)*NSIDE + s;
                idx_basal = (p - 1)*NROI*NSIDE + (BASAL_ROI - 1)*NSIDE + s;
                idx_white = (p - 1)*NROI*NSIDE + (WHITE_ROI - 1)*NSIDE + s; 
                theValues(idx_grey)  = refValue*theValues(idx_grey )/refRawValues(idx_grey);
                theValues(idx_basal) = refValue*theValues(idx_basal)/refRawValues(idx_basal);
                theValues(idx_white) = refValue*theValues(idx_white)/refRawValues(idx_white);
            end
        end

    end
        
end


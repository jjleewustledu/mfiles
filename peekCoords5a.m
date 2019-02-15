%PEEKCOORDS5
%
% Usage:  sumValues = peekCoords5a(kindRoi, kindImg, side, moment, ref_tissue, blur)
%
%         sumValues will be a vector of doubles, one for each pid
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

function theValues = peekCoords5a(kindRoi, kindImg, side, moment, ref_tissue, blur)

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
    excludeCsf = ~strcmp('ho1', kindImg);
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

    sumValues    = zeros(NROI,NSIDE);
    refRawValues = zeros(NPID);
    if (ref_tissue)  
        for p1 = 1:NPID
            theImg = squeeze(peekPerfusion(p, kindImg, 0, [0,0], 'dip'));
            tmpImg = (theImg > 0) .* theImg;
            if (blur)
				sigmas = [fwhh*0.42553 fwhh*0.42553 fwhh*0.06649];
                tmpImg = gaussAnisof(tmpImg, sigmas); 
			end % 1 mm fwhh blur in all directions 
                    
            % using only white-matter ref.
            refRoi = peekRefRois(p1); %%% getPermutedRoi(p, KIND_REF_ROI, side, WHITE_ROI, s, NSIDE, theRois); 
            refRawValues(p) = peekDoubleCoord(refRoi, tmpImg, moment, p1, kindImg);  
        end
    end

    extendRoi = newim(DIMX,DIMY,DIMZ,NPID);
    extendImg = newim(DIMX,DIMY,DIMZ,NPID);

    for r = 1:NROI
        for s = 1:NSIDE
            for p = 1:NPID

                if (pidToExclude(p, kindImg))
                    disp(['excluding pid -> ' num2str(p) ', roi -> ' num2str(r) ', side -> ' num2str(s)]);
                    continue; 
                end

                [grey, basal, white, allRois] = peekRois(p, kindRoi, 'dip', 0, excludeCsf);
                theRois = { grey, basal, white };
                extendRoi(:,:,:,p) = getPermutedRoi(p, kindRoi, side, r, s, NSIDE, theRois);

                theImg = squeeze(peekPerfusion(p, kindImg, 0, [0,0], 'dip'));
                tmpImg = (theImg > 0) .* theImg;
                if (blur)
					sigmas = fwhh*[0.42553 0.42553 0.06649];
                    tmpImg = gaussAnisof(tmpImg, sigmas); 
				end % fwhh * 1 mm fwhh blur in all directions                            
                extendImg(:,:,:,p) = tmpImg;
                if ~strcmp('dip_image', class(extendImg)), 
                    error(['extendImg->' kindImg ' for pid->' pidList(p) ' was not numeric']); end

                tmpValue = peekDoubleCoord(extendRoi, extendImg, moment, p, kindImg);

                if strcmp('ho1', kindImg) && moment > 0,
                    tmpValue = counts_to_petCbf(tmpValue, p); end

                if ~ref_tissue,
                    tmpValue = cutoffValues(tmpValue, kindImg, moment); end
                
                if ref_tissue,       
                    tmpValue = refValue*tmpValue/refRawValues(r,s); end

                if (strcmp('ho1', kindImg) && moment > 0)
                    sumValues(r,s) = sumValues(r,s) + counts_to_petCbf(tmpValue, p);
                else
                    sumValues(r,s) = sumValues(r,s) + tmpValue;
                end

            end
        end    
    end
    
    theValues = sumValues/pidCount(kindImg); 

end









%
%  USAGE:  arteries = getArteries(pnum, study, epi, fg)
%
%          pnum:
%          study:       string, e.g., 'np797' (optional)
%          epi:         dip_image (optional)
%          fg:          dip_image (optional)
%          arteries:    floating-point dip_image 
%
%  Created by John Lee on 2008-04-09.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function [arteries fg] = getArteries(pnum, study, epi, fg)

    FRAMES_BEFORE_BOLUS = 1;

	switch (nargin)
		case 1
            study = 'np287';
            epi   = 0;
            fg    = 0;
        case 2
            epi   = 0;
            fg    = 0;
        case 3
            fg    = 0;
        case 4
		otherwise
			error(help('getArteries'));
    end
    switch (study)
        case 'np287'
            pathway = [peekDrive() '/perfusion/vc/' pnum '/ROIs/Xr3d/'];
            pathepi = [peekDrive() '/perfusion/vc/' pnum '/4dfp/'];
        case 'np797'
            pathway = [peekDrive() '/np797/' pnum '/4dfp/'];
            pathepi = pathway;
        otherwise
            error(['getArteries:  could not recognize study ' study]);
    end
    
    sizes       = peek4dfpSizes(study);
    epiSState   = 4;
    epiFrames   = sizes(4);
    [pnum p]     = ensurePid(pnum);  
    
    if (~epi)
        epi     = getEpi(pnum, study); end
    if (~fg)
        fg      = getFg(sizes, pathway, pathepi, pnum, study); end            
           
    epimip      = newim(epiFrames);
    t_bolus     = -1;
    minmip      = realmax;
    for t = 0:epiFrames-1
        epimip(t) = sum(squeeze(epi(:,:,:,t)) .* squeeze(fg));
        if (epimip(t) < minmip)
            minmip = epimip(t);
            t_bolus = t;
        end
    end
    epibaseline = newim(sizes(1),sizes(2),sizes(3));
    tLast       = floor(mean([epiSState t_bolus-FRAMES_BEFORE_BOLUS]));
    for t = epiSState:tLast
        epibaseline = epibaseline + squeeze(epi(:,:,:,t));
    end
    t_bolus
    arteries    = epibaseline/mean(epibaseline) - ...
                  squeeze(epi(:,:,:,t_bolus-FRAMES_BEFORE_BOLUS)/ ...
                      mean(epi(:,:,:,t_bolus-FRAMES_BEFORE_BOLUS)));
    arteries    = arteries .* (arteries > 0) .* fg;
    arteries    = gaussAnisof(arteries, [1 1 0]);
    arteries    = arteries / sum(arteries); % normalize image values to be probabilities
    
    
    

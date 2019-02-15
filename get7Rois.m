
%
% Usage:    masks = get7ROis(pnum, filenameSuffix)
%
%           pnum:        string or int index
%           masks:      struct containing 8 ROIs:
%
%                       fg, grey, caudate, putamen, thalamus, white, arteries, csf
%
%_____________________________________________________________________________________

function masks = get7Rois(pnum, fnSuffix)

    mutuallyExclusiveMasks = 1;
	typicalTtp = 40;
    
    switch (nargin)
        case 1
            fnSuffix = roiSuffix(pnum);
        case 2
        otherwise
            error(help('get7Rois'));
    end
    
    sizes       = db('sizes3d', pid2np(pnum));
    sizes4d     = db('sizes4d', pid2np(pnum));
    epiSState   = 4;
    epiFrames   = max(typicalTtp, sizes4d(4));
    [pnum p]     = ensurePid(pnum, pid2np(pnum));
    pathway     = [peekDrive '/' pid2np(pnum) '/' pnum '/ROIs/Xr3d/'];
    pathepi     = [peekDrive '/' pid2np(pnum) '/' pnum '/4dfp/'];

    % COMPUTE ROIS (FLOAT)
    
    grey        = squeeze(read4d([pathway 'grey' fnSuffix '.4dfp.img'], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),1,0,0,0));
    caudate     = squeeze(read4d([pathway 'caudate' fnSuffix '.4dfp.img'], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),1,0,0,0));
    putamen     = squeeze(read4d([pathway 'putamen' fnSuffix '.4dfp.img'], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),1,0,0,0));
    thalamus    = squeeze(read4d([pathway 'thalamus' fnSuffix '.4dfp.img'], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),1,0,0,0));
    white       = squeeze(read4d([pathway 'white' fnSuffix '.4dfp.img'], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),1,0,0,0));
    csf         = squeeze(read4d([pathway 'csf' fnSuffix '.4dfp.img'], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),1,0,0,0)); 
    try
        epi     = squeeze(read4d([pathepi perfusionVenousFilename(p)], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),epiFrames,0,0,0));
    catch ME
        disp(ME.message);
        error('NIL:get7Rois:IOErr', ...
            ['could not open the EPI data at ' pathepi perfusionVenousFilename(p)]);
    end    
    fg          = getFg(sizes, pathway, pathepi, pnum, pid2np(pnum));                    
            
    grey        = gaussAnisof(grey,                         [0.7 0.7 0]) .* fg; 
    caudate     = gaussAnisof(caudate,                      [1   1   0]) .* fg;
    putamen     =             putamen                                    .* fg;
    thalamus    =             thalamus                                   .* fg;
    fatbg       = gaussAnisof(caudate + putamen + thalamus, [2   2   0]) .* fg;
    white       = gaussAnisof(white,                        [1   1   0]) .* fg;
    csf         =             csf                                        .* fg;
                      
    % COMPUTE ARTERIES (FLOAT)    
    
    epimip      = newim(epiFrames);
    t_bolus     = -1;
    minmip      = realmax;
    for t = 0:epiFrames-1
        epimip(t) = sum(squeeze(epi(:,:,:,t)) .* fg);
        if (epimip(t) < minmip)
            minmip = epimip(t);
            t_bolus = t;
        end
    end
    epibaseline = newim(size(fg));
    tLast       = mean([epiSState t_bolus-1]);
    for t = epiSState:tLast
        epibaseline = epibaseline + squeeze(epi(:,:,:,t));
    end
    arteries    = epibaseline/max(epibaseline) - ...
                  squeeze(epi(:,:,:,t_bolus-1)/ ...
                      max(epi(:,:,:,t_bolus-1)));
    arteries    = gaussAnisof(arteries,                     [1 1 0]) .* fg;
    
    % CONVERT TO BOOLEAN
    
    fg              = fg > eps;
    grey            = thresholdedBool(grey, 1.7) & ~thresholdedBool(fatbg);
    caudate         = thresholdedBool(caudate);
    putamen         = thresholdedBool(putamen, 1.0);
    thalamus        = thresholdedBool(thalamus, 1.0);
    white           = thresholdedBool(white, 0.0) & ~thresholdedBool(fatbg);
    arteries        = thresholdedBool(arteries, 2.5);
    csf             = thresholdedBool(csf, 1.7);
    
    maskCells       = cell(1,7);
    maskCells{1}    = caudate;
    maskCells{2}    = putamen;
    maskCells{3}    = thalamus;   
    maskCells{4}    = white;
    maskCells{5}    = csf;
    maskCells{6}    = grey;
    maskCells{7}    = arteries;
    if (mutuallyExclusiveMasks)
        maskCells   = makeMasksMutuallyExclusive(maskCells); end
    
    % ASSIGN STRUCT TO RETURN
    
    masks.fg        = fg;
    masks.caudate   = maskCells{1};    
    masks.putamen   = maskCells{2};
    masks.thalamus  = maskCells{3};
    masks.white     = maskCells{4};
    masks.csf       = maskCells{5};    
    masks.grey      = maskCells{6};
    masks.arteries  = maskCells{7};
    masks.basalganglia = masks.caudate | masks.putamen | masks.thalamus;

    % SANITY CHECK

	assert(prod(size(masks.fg))       == prod(db('sizes3d')), ...
        ['masks.fg had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.grey))     == prod(db('sizes3d')), ...
        ['masks.grey had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.white))    == prod(db('sizes3d')), ...
        ['masks.white had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.caudate))  == prod(db('sizes3d')), ...
        ['masks.caudate had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.putamen))  == prod(db('sizes3d')), ...
        ['masks.putamen had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.thalamus)) == prod(db('sizes3d')), ...
        ['masks.thalamus had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.arteries)) == prod(db('sizes3d')), ...
        ['masks.arteries had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.csf))      == prod(db('sizes3d')), ...
        ['masks.csf had unexpected size ' num2str(db('sizes3d'))]);
    
    % VISUALIZE CSF, GREY, ARTERIES FOR CROSS-CHECKING
    
    dipshow(masks.csf);
    dipshow(masks.grey);
    dipshow(masks.arteries);
    
end


%
% Usage:    masks = get5Rois(pnum, filenameSuffix)
%
%           pnum:            string or int index
%           filenameSuffix: e.g., '_xr3d'
%           masks:          struct containing 5 ROIs:
%
%                           fg, grey, white, arteries, csf
%
%_____________________________________________________________________________________

function masks = get5Rois(pnum, fnSuffix)

    MAKE_MASKS_MUTUALLY_EXCLUSIVE = 1;
    FRAMES_BEFORE_BOLUS           = 1;
    
    switch (nargin)
        case 1
            fnSuffix = '_Xr3d';
        case 2
        otherwise
            error(help('get5Rois'));
    end;
    
    sizes       = peek4dfpSizes(pid2np(pnum));
    epiSState   = 4;
    epiFrames   = max(40, sizes(4));
    [pnum p]     = ensurePid(pnum);
    pathway     = pathFg(pnum);
    path4dfp    = pathEpi(pnum);

    % COMPUTE ROIS (FLOAT)
    
    grey        = squeeze(read4d([pathway 'grey' fnSuffix '.4dfp.img'], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),sizes(4),0,0,0));
    white       = squeeze(read4d([pathway 'white' fnSuffix '.4dfp.img'], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),sizes(4),0,0,0));
    csf         = squeeze(read4d([pathway 'csf' fnSuffix '.4dfp.img'], 'ieee-be', 'float', ...
                sizes(1),sizes(2),sizes(3),sizes(4),0,0,0)); 
    
    try
        epi     = getEpi(pnum, pid2np(pnum));
    catch ME
        disp(ME.message);
        error('get5Rois:  could not open the EPI data');
    end    
    fg          = getFg(sizes, pathway, path4dfp, pnum, pid2np(pnum));                    
            
    grey        = gaussAnisof(squeeze(grey),  [0.7 0.7 0]) .* fg; 
    white       = gaussAnisof(squeeze(white), [1   1   0]) .* fg;
    csf         =             csf                          .* fg;
                      
    [arteries fg] = getArteries(pnum, pid2np(pnum), epi, fg)
    
    % CONVERT TO BOOLEAN
    
    fg              = fg > eps;
    grey            = thresholdedBool(grey, 1.7);
    white           = thresholdedBool(white, 0.0);
    arteries        = thresholdedBool(arteries, 2.2);
    csf             = thresholdedBool(csf, 1.7);
    
    maskCells       = cell(1,4);
    maskCells{1}    = white;
    maskCells{2}    = csf;
    maskCells{3}    = grey;
    maskCells{4}    = arteries;
    if (MAKE_MASKS_MUTUALLY_EXCLUSIVE)
        maskCells   = makeMasksMutuallyExclusive(maskCells); end

    % ASSIGN STRUCT TO RETURN
    
    masks.fg        = fg;
    masks.white     = maskCells{1};
    masks.csf       = maskCells{2};    
    masks.grey      = maskCells{3};
    masks.arteries  = maskCells{4};
    
    % SANITY CHECK

    assert(prod(size(masks.fg))       == prod(db('sizes3d')), ...
        ['masks.fg had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.grey))     == prod(db('sizes3d')), ...
        ['masks.grey had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.white))    == prod(db('sizes3d')), ...
        ['masks.white had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.arteries)) == prod(db('sizes3d')), ...
        ['masks.arteries had unexpected size ' num2str(db('sizes3d'))]);
    assert(prod(size(masks.csf))      == prod(db('sizes3d')), ...
        ['masks.csf had unexpected size ' num2str(db('sizes3d'))]);
    
    % VISUALIZE CSF, GREY, ARTERIES FOR CROSS-CHECKING
    
    dipshow(masks.csf);
    dipshow(masks.grey);
    dipshow(masks.arteries);
    
    

    
        
        
    

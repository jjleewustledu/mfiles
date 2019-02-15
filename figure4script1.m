
%
% Usage:    imgData = figure4script1s(pid)
%
%           pid:        string or int index
%
%________________________________________________________________________________________________

function [xVec yVec y2Vec] = figure4script1(pid)

    switch (nargin)
        case 1
            aMetric    = 'cbf'
            imgData    = makeImgData(pid, aMetric);
            masks      = false;
            sliceRange = [0 imgData.sizes3d(3)-1];
            xRange     = 'nil';
            yRange     = 'nil';

        otherwise
            error(help('publishPlots_singlepatient_gen'));
    end    
    
    Unity      = dip_image(ones(imgData.sizes3d));
    UnitSlice  = dip_image(ones(imgData.sizes3d(1),imgData.sizes3d(2)));
    Zero       = newim(imgData.sizes3d);
    sliceBlock = Zero;
    [pid, p]   = ensurePid(pid);
    switch (pid2np(pid))
        case 'np287'            
            for s = sliceRange(1):sliceRange(2)
                if (s == slice1(pid) || s == slice2(pid))
                    sliceBlock(:,:,s) = UnitSlice; end
            end
            if islogical(masks),
                masks = get7Rois(pid); end

            disp('publishPlots_singlepatient_gen:  showing parenchyma mask for cross-checks.');
            masks.fg   = masks.fg  & sliceBlock;
            parenchyma = masks.fg & (masks.grey | masks.white | masks.basalganglia);

        case 'np797'
            sliceBlock = Unity;
            if islogical(masks),
                masks = get5Rois(pid); end
              
            disp('publishPlots_singlepatient_gen:  showing parenchyma mask for cross-checks.');
            masks.fg   = masks.fg  & sliceBlock;
            parenchyma = masks.fg & (masks.grey | masks.white);

        otherwise

            error(['publishPlots_singlepatient_gen:   could not recognize pid2np(' pid ') -> ' ...
                   pid2np(pid)]);
    end
    
    cd(['/mnt/hgfs/' pid2np(pid) '/' pidFolder(pid) '/Figures']);
    
   
    xIdx  = 1; %%%tag2idx(X_IMAGE_NAME,  imgData);
    yIdx  = 2; %%%tag2idx(Y_IMAGE_NAME,  imgData);
    y2Idx = 3; %%%tag2idx(Y2_IMAGE_NAME, imgData);
    

                
        % BINNING VOXELS
        
        binSizes = [db('binlength') db('binlength') 1];
        binUnity = binVoxels(Unity, binSizes);
        binParen = binVoxels(parenchyma, binSizes);
        
        xImage                 = imgData.images{xIdx};
        xImage.mmppix          = imgData.images{xIdx}.mmppix .* binSizes;
        xImage.pnum             = imgData.pnum; % kludge
        [xVec xImage.dipImage] = peekDoubleVoxels(binParen, binVoxels(xImage.dipImage, binSizes));
        
        yImage                 = imgData.images{yIdx};  
        yImage.mmppix          = imgData.images{yIdx}.mmppix .* binSizes;
        yImage.pnum             = imgData.pnum; % kludge
        [yVec yImage.dipImage] = peekDoubleVoxels(binParen, binVoxels(yImage.dipImage, binSizes));
        
        y2Image                  = imgData.images{y2Idx};  
        y2Image.mmppix           = imgData.images{y2Idx}.mmppix .* binSizes;
        y2Image.pnum              = imgData.pnum; % kludge
        [y2Vec y2Image.dipImage] = peekDoubleVoxels(binParen, binVoxels(y2Image.dipImage, binSizes));

    

     


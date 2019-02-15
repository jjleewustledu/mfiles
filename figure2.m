
%
% Usage:    imgData = figure2(pid, imgData, masks, sliceRange, xRange, yRange)
%
%           pid:        string or int index
%           imgData:    struct, described in makeImgData
%           masks:      struct containing tissue masks           
%                       set to false or 0 to generate masks      (option)
%           sliceRange: [3 10] to display and print              (option)
%           *Range:     [0 0.35] or non-double marker, e.g., '0' (option)
%
% Notes:    imgData.images{i} will be reused if it exists according to function ismember(...)
%________________________________________________________________________________________________

function [imgData masks yImg] = figure2( ...
                           pid, aMetric, xRange, yRange, sliceRange, masks)

    WRITE_IMAGE_SLICES   = 1;
    WRITE_SCATTERS       = 1;
    WRITE_BLAND_ALTMANS  = 1;
    X_SCALE              = 1;
    Y_SCALE              = 1;    
    pb                   = db('petblur');
    X_BLUR_LABEL         = [num2str(pb(1)) 'mm'];
    mb                   = db('mrblur');
    Y_BLUR_LABEL         = [num2str(mb(1)) 'mm'];   
    MAX_VAL_BLAND_ALTMAN = 120
    SIZES                = db('sizes3d');
    PAINT_GRID           = 0;

    switch (nargin)
        case 1
            aMetric    = 'CBF';
            xRange     = 'nil';
            yRange     = 'nil';
            sliceRange = [0 SIZES(3)-1];
            masks      = 0;
        case 2
            xRange     = 'nil';
            yRange     = 'nil';
            sliceRange = [0 SIZES(3)-1];
            masks      = 0;
        case 3
            yRange     = 'nil';
            sliceRange = [0 SIZES(3)-1];
            masks      = 0;
        case 4
            sliceRange = [0 SIZES(3)-1];
            masks      = 0;
        case 5
            masks      = 0;
        case 6
        otherwise
            error(help('figure2'));
    end
    
    Y_IMAGE_NAME         = ['MR LAIF ' aMetric];
    Y2_IMAGE_NAME        = ['MR MLEM ' aMetric];
    X_IMAGE_NAME         = ['PET '     aMetric];
    imgData    = makeImgData(pid, aMetric);
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
            if (~isa(masks, 'struct'))
                masks = get7Rois(pid); end

            disp('publishPlots_singlepatient_gen:  showing parenchyma mask for cross-checks.');
            masks.fg   = masks.fg  & sliceBlock;
            parenchyma = masks.fg & ~(masks.arteries | masks.csf)

        case 'np797'

            sliceBlock = Unity;
            if (~isa(masks, 'struct'))
                masks = get5Rois(pid); end
              
            disp('publishPlots_singlepatient_gen:  showing parenchyma mask for cross-checks.');
            masks.fg   = masks.fg  & sliceBlock;
            parenchyma = masks.fg & ~(masks.arteries | masks.csf)

        otherwise

            error(['publishPlots_singlepatient_gen:   could not recognize pid2np(' pid ') -> ' ...
                   pid2np(pid)]);
    end
    
    cd(['/mnt/hgfs/' pid2np(pid) '/' pidFolder(pid) '/Figures']);
    
    % SHOW BLURRED IMAGES, 4-SCATTER PLOTS AND BLAND-ALTMAN PLOTS
    % WRITE EPS-RENDERINGS TO DISK
    
    xIdx  = 1; %tag2idx(X_IMAGE_NAME,  imgData);
    yIdx  = 2; %tag2idx(Y_IMAGE_NAME,  imgData);
    y2Idx = 3; %tag2idx(Y2_IMAGE_NAME, imgData);
    
    if (WRITE_IMAGE_SLICES | WRITE_SCATTERS | WRITE_BLAND_ALTMANS)   
        imgData = readImage(imgData, xIdx);
		if X_SCALE ~= 1,
        	imgData.images{xIdx} = X_SCALE * imgData.images{xIdx}; end

		imgData = readImage(imgData, yIdx);
		if Y_SCALE ~= 1,
            imgData.images{yIdx} = Y_SCALE * imgData.images{yIdx}; end
        
        imgData = readImage(imgData, y2Idx);
		if Y_SCALE ~= 1,
            imgData.images{y2Idx} = Y_SCALE * imgData.images{y2Idx}; end
        
    end
    
    if (WRITE_IMAGE_SLICES)
        
        % BLURRING HERE!!!!!!
            
        finMask       = ~(masks.fg &(~masks.arteries) &(~masks.csf));
        masks.finMask = finMask;

        xBlurredImg = dip_image( ...
            gaussAnisofFwhh(imgData.images{xIdx}.dipImage, ...
                imgData.images{xIdx}.fwhh, imgData.images{xIdx}.mmppix));
        yBlurredImg = dip_image( ...
            gaussAnisofFwhh(imgData.images{yIdx}.dipImage, ...
                imgData.images{xIdx}.fwhh, imgData.images{xIdx}.mmppix));                   
        yImg = dip_image( ...
            imgData.images{yIdx}.dipImage);
                
        cd([db('basepath') '/' db('study') '/' pid '/Figures'])
        xRangeLbl = '';
        if (isa(xRange, 'double') & numel(xRange) == 2)
            xRangeLbl = ['_range' num2str(xRange(1)) 'to' num2str(xRange(2))];
        end
        yRangeLbl = '';
        if (isa(yRange, 'double') & numel(yRange) == 2)
            yRangeLbl = ['_range' num2str(yRange(1)) 'to' num2str(yRange(2))];
        end
        for aSlice = sliceRange(1):sliceRange(2)
            if (slice1(pid) == aSlice || slice2(pid) == aSlice)
                sliceLabel = ['slice' num2str(aSlice)];
                
                % PUBLISH PET
                
                if (isa(xRange, 'double'))
                    publishImage_singlepatient(xBlurredImg, ...
                        aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel xRangeLbl '_fig2c'], ...
                        xRange, 'jet')
                    publishImage_singlepatient(xBlurredImg,  ...
                        aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel xRangeLbl '_fig2d'], ...
                        xRange, 'jet', true)
                    publishImage_singlepatient(finMask, ...
                        aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel xRangeLbl '_fig2doverlay'], ...
                        [], 'gray', true)
                else
                    publishImage_singlepatient(xBlurredImg, ...
                        aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel '_fig2c'], ...
                        [], 'jet')
                    publishImage_singlepatient(xBlurredImg, ...
                        aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel '_fig2d'], ...
                        [], 'jet', true)
                    publishImage_singlepatient(finMask, ...
                        aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel '_fig2doverlay'], ...
                        [], 'gray', true)
                end
                
                % PUBLISH MR
                
                if (isa(yRange, 'double'))
                    publishImage_singlepatient(yImg, ...
                        aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName Y_BLUR_LABEL '_' sliceLabel yRangeLbl '_fig2a'], ...
                        yRange, 'jet', true)
                    if (PAINT_GRID)
                        publishImage_singlepatient(squeeze(paintGridlines(db('binlength'))), ...
                            aSlice, imgData.images{yIdx }.units,...
                            [imgData.images{yIdx }.imageSafeName Y_BLUR_LABEL '_' sliceLabel yRangeLbl '_fig2aoverlay'], ...
                            [], 'gray', true)
                    end
                    publishImage_singlepatient(yBlurredImg, ...
                        aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName '_' sliceLabel yRangeLbl '_fig2b'], ...
                        [], 'jet')
                else
                    publishImage_singlepatient(yImg, ...
                        aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName Y_BLUR_LABEL '_' sliceLabel '_fig2a'],...
                        [], 'jet', true)
                    if (PAINT_GRID)
                        publishImage_singlepatient(squeeze(paintGridlines(db('binlength'))), ...
                            aSlice, imgData.images{yIdx }.units,...
                            [imgData.images{yIdx }.imageSafeName Y_BLUR_LABEL '_' sliceLabel '_fig2aoverlay'], ...
                            [], 'gray', true)
                    end
                    publishImage_singlepatient(yBlurredImg, ...
                        aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName '_' sliceLabel '_fig2b'], ...
                        [], 'jet')
                end
            end
        end
        
%         finMask = masks.finMask(:,:,0);
%         [roi, v]      = diproi(15,'spline') % roi = getFg();
%         finMask       = squeeze(finMask) |~roi;
%         binMask       = binVoxels(finMask, [10 10]);
%         masks.binMask = dip_image(double(binMask > 0.5));

    end




	function idx = tag2idx(imgTag, imgDat)
		
        idx = -1;
		switch class(imgTag)
			case 'double'
				idx = imgTag;
			case 'char'
				for i = 1:size(imgDat.images,2)
					if (strcmp(imgTag, imgDat.images{i}.imageName) | ...
                        strcmp(imgTag, imgDat.images{i}.imageSafeName)) 
						idx = i;
                        break
                    end
				end
			otherwise
				error(['publishPlots_singlepatient_gen.tag2idx:  could not recognize the class of imgTag -> ' class(imgTag)]);
		end

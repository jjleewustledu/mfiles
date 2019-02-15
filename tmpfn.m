
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

function [imgData masks] = tmpfn( ...
                           pid, imgData, masks, sliceRange, xRange, yRange)

    WRITE_IMAGE_SLICES   = 1;
    WRITE_SCATTERS       = 1;
    WRITE_BLAND_ALTMANS  = 1;
    X_SCALE              = 1;
    Y_SCALE              = 1;    
    pb                   = db('petblur');
    X_BLUR_LABEL         = [num2str(pb(1)) 'mm'];
    mb                   = db('mrblur');
    Y_BLUR_LABEL         = [num2str(mb(1)) 'mm'];
    Y_IMAGE_NAME         = 'MR LAIF MTT';
    Y2_IMAGE_NAME        = 'MR MLEM MTT';
    X_IMAGE_NAME         = 'PET MTT';    
    MAX_VAL_BLAND_ALTMAN = 10

    switch (nargin)
        case 1
            imgData    = makeImgData(pid, 'mtt');
            masks      = false;
            sliceRange = [0 imgData.sizes3d(3)-1];
            xRange     = 'nil';
            yRange     = 'nil';
        case 2
            masks      = false;
            sliceRange = [0 imgData.sizes3d(3)-1];
            xRange     = 'nil';
            yRange     = 'nil';
        case 3
            sliceRange = [0 imgData.sizes3d(3)-1];
            xRange     = 'nil';
            yRange     = 'nil';
        case 4
            xRange     = 'nil';
            yRange     = 'nil';
        case 5
            yRange     = 'nil';
        case 6
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
            parenchyma = masks.fg & (masks.grey | masks.white | masks.basalganglia)

        case 'np797'

            sliceBlock = Unity;
            if islogical(masks),
                masks = get5Rois(pid); end
              
            disp('publishPlots_singlepatient_gen:  showing parenchyma mask for cross-checks.');
            masks.fg   = masks.fg  & sliceBlock;
            parenchyma = masks.fg & (masks.grey | masks.white)

        otherwise

            error(['publishPlots_singlepatient_gen:   could not recognize pid2np(' pid ') -> ' ...
                   pid2np(pid)]);
    end
    
    cd(['/mnt/hgfs/' pid2np(pid) '/' pidFolder(pid) '/Figures']);
    
    % SHOW BLURRED IMAGES, 4-SCATTER PLOTS AND BLAND-ALTMAN PLOTS
    % WRITE EPS-RENDERINGS TO DISK
    
    xIdx  = tag2idx(X_IMAGE_NAME,  imgData);
    yIdx  = tag2idx(Y_IMAGE_NAME,  imgData);
    y2Idx = tag2idx(Y2_IMAGE_NAME, imgData);
    
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
            
        finMask = ~(masks.fg & (~masks.arteries) & (~masks.csf));

        xBlurredImg = dip_image( ...
            gaussAnisofFwhh(imgData.images{xIdx}.dipImage, ...
                imgData.images{xIdx}.fwhh, imgData.images{xIdx}.mmppix));
        yBlurredImg = dip_image( ...
            gaussAnisofFwhh(imgData.images{yIdx}.dipImage, ...
                imgData.images{xIdx}.fwhh, imgData.images{xIdx}.mmppix));        
%         y2BlurredImg = dip_image( ...
%             gaussAnisofFwhh(imgData.images{y2Idx}.dipImage, ...
%                 imgData.images{xIdx}.fwhh, imgData.images{xIdx}.mmppix));            
        yImg = dip_image( ...
            imgData.images{yIdx}.dipImage);
%         y2Img = dip_image( ...
%             imgData.images{y2Idx}.dipImage);
                
        cd([db('basepath') '/' db('study') '/' pid '/Figures'])
        for aSlice = sliceRange(1):sliceRange(2)
            if (slice1(pid) == aSlice || slice2(pid) == aSlice)
                sliceLabel = ['slice' num2str(aSlice)];
                if (isa(xRange, 'double'))
                    publishImage_singlepatient(xBlurredImg,  aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel '_maxrange' num2str(xRange(2)) '_fig2c'], xRange, 'jet')
                    publishImage_singlepatient(xBlurredImg,  aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel '_maxrange' num2str(xRange(2)) '_fig2d'], xRange, 'jet', true)
                    publishImage_singlepatient(finMask,      aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel '_maxrange' num2str(xRange(2)) '_fig2doverlay'], xRange, 'gray', true)
                else
                    publishImage_singlepatient(xBlurredImg,  aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel '_fig2c'], [], 'jet')
                    publishImage_singlepatient(xBlurredImg,  aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel '_fig2d'], [], 'jet', true)
                    publishImage_singlepatient(finMask,      aSlice, imgData.images{xIdx}.units,...
                        [imgData.images{xIdx}.imageSafeName  X_BLUR_LABEL '_' sliceLabel '_fig2doverlay'], [], 'gray', true)
                end
                if (isa(yRange, 'double'))
                    publishImage_singlepatient(yImg,         aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName Y_BLUR_LABEL '_' sliceLabel '_maxrange' num2str(yRange(2)) '_fig2a'], yRange, 'jet', true)
                    publishImage_singlepatient(squeeze(paintGridlines(db('binlength'))), ...
                                                             aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName Y_BLUR_LABEL '_' sliceLabel '_maxrange' num2str(yRange(2)) '_fig2aoverlay'], yRange, 'gray', true)
%                     publishImage_singlepatient(y2BlurredImg, aSlice, imgData.images{y2Idx}.units,...
%                         [imgData.images{y2Idx}.imageSafeName Y_BLUR_LABEL '_' sliceLabel '_maxrange' num2str(yRange(2)) '_fig2'], yRange)
                    publishImage_singlepatient(yBlurredImg,  aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName '_' sliceLabel '_maxrange' num2str(yRange(2)) '_fig2b'], yRange, 'jet')
%                     publishImage_singlepatient(y2Img, aSlice, imgData.images{y2Idx}.units,...
%                         [imgData.images{y2Idx}.imageSafeName '_' sliceLabel '_maxrange' num2str(yRange(2)) '_fig2'], yRange)
                else
                    publishImage_singlepatient(yImg,         aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName Y_BLUR_LABEL '_' sliceLabel '_fig2a'], [], 'jet', true)
                    publishImage_singlepatient(squeeze(paintGridlines(db('binlength'))), ...
                                                             aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName Y_BLUR_LABEL '_' sliceLabel '_fig2aoverlay'], [], 'gray', true)
%                     publishImage_singlepatient(y2BlurredImg, aSlice, imgData.images{y2Idx}.units,...
%                         [imgData.images{y2Idx}.imageSafeName Y_BLUR_LABEL '_' sliceLabel '_fig2'])
                    publishImage_singlepatient(yBlurredImg,  aSlice, imgData.images{yIdx }.units,...
                        [imgData.images{yIdx }.imageSafeName '_' sliceLabel '_fig2b'], [], 'jet')
%                     publishImage_singlepatient(y2Img, aSlice, imgData.images{y2Idx}.units,...
%                         [imgData.images{y2Idx}.imageSafeName '_' sliceLabel '_fig2'])
                end
            end
        end
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

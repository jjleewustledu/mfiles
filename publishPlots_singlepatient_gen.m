
%
% Usage:    imgData = publishPlots_singlepatient_gen(pid, imgData, masks, sliceRange, rng1, rng2, rng3)
%
%           pid:        string or int index
%           imgData:    struct, described in makeImgData
%           masks:      struct containing tissue masks           
%                       set to false or 0 to generate masks      (option)
%           sliceRange: [3 10] to display and print              (option)
%           rng*:       [0 0.35] or non-double marker, e.g., '0' (option)
%
% Notes:    imgData.images{i} will be reused if it exists according to function ismember(...)
%________________________________________________________________________________________________

function [imgData] = publishPlots_singlepatient_gen( ...
                           pid, aMetric, imgData, sliceRange, rng1, rng2, rng3)

    WRITE_IMAGE_SLICES   = 0;
    WRITE_SCATTERS       = 1;
    WRITE_BLAND_ALTMANS  = 0;    
    pb                   = db('petblur');
	mb                   = db('mrblur');
    BLUR_LBL_1           = ['_' num2str(pb(1)) 'mm'];    
    BLUR_LBL_2           = ['_' num2str(mb(1)) 'mm']; 
    MAX_AMPLITUDE        = 3

    switch (nargin)
        case 1
            aMetric    = 'cbf'
            imgData    = makeImgData(pid, aMetric);
            sliceRange = [0 imgData.sizes3d(3)-1];
            rng1       = 'nil';
            rng2       = 'nil';
			rng3       = 'nil';
        case 2
            imgData    = makeImgData(pid, aMetric);
            sliceRange = [0 imgData.sizes3d(3)-1];
            rng1       = 'nil';
            rng2       = 'nil';
			rng3       = 'nil';
        case 3
            sliceRange = [0 imgData.sizes3d(3)-1];
            rng1       = 'nil';
            rng2       = 'nil';
			rng3       = 'nil';
        case 4
            rng1 = 'nil';
            rng2 = 'nil';
			rng3 = 'nil';
        case 5
            rng2 = 'nil';
			rng3 = 'nil';
        case 6	
			rng3 = 'nil';
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
            if islogical(imgData.masks),
                imgData.masks = get7Rois(pid); end
            disp('publishPlots_singlepatient_gen:  showing parenchyma mask for cross-checks.');
            imgData.masks.fg         = imgData.masks.fg & sliceBlock;
            imgData.masks.parenchyma = imgData.masks.fg & (imgData.masks.grey | imgData.masks.white | imgData.masks.basalganglia)

        case 'np797'
            sliceBlock = Unity;
            if islogical(imgData.masks),
                imgData.masks = get5Rois(pid); end              
            disp('publishPlots_singlepatient_gen:  showing parenchyma mask for cross-checks.');
            imgData.masks.fg         = imgData.masks.fg & sliceBlock;
            imgData.masks.parenchyma = imgData.masks.fg & (imgData.masks.grey | imgData.masks.white)

        otherwise
            error(['publishPlots_singlepatient_gen:   could not recognize pid2np(' pid ') -> ' ...
                   pid2np(pid)]);
    end    
    cd(['/mnt/hgfs/' pid2np(pid) '/' pidFolder(pid) '/Figures']);
    
    if (WRITE_IMAGE_SLICES)
        disp('Writing image slices..........');
        blurredImgData = blurImgData(imgData, imgData.masks.fg);
        for aSlice = sliceRange(1):sliceRange(2)
	
            if (slice1(pid) == aSlice || slice2(pid) == aSlice)
	
                sliceLbl = ['_slice' num2str(aSlice)];
                if (isnumeric(rng1) | isnumeric(rng2) | isnumeric(rng3))
					blurredImgData.images{1}.range = rng1;
					blurredImgData.images{2}.range = rng2;
					blurredImgData.images{3}.range = rng3;
					blurredImgData.images{1}.imageName = ...
						[  imgData.images{1}.imageSafeName BLUR_LBL_1 sliceLbl '_rng' num2str(rng1(1)) '-' num2str(rng1(2))];
					blurredImgData.images{2}.imageName = ...
						[  imgData.images{2}.imageSafeName BLUR_LBL_2 sliceLbl '_rng' num2str(rng2(1)) '-' num2str(rng2(2))];
					blurredImgData.images{3}.imageName = ...
						[  imgData.images{3}.imageSafeName BLUR_LBL_2 sliceLbl '_rng' num2str(rng3(1)) '-' num2str(rng3(2))];
                    mlpublish.ImagePublisher.publishImgsCoeffVar(blurredImgData,  aSlice, 'jet', true);
                else
					blurredImgData.images{1}.imageName = ...
						[  imgData.images{1}.imageSafeName BLUR_LBL_1 sliceLbl];
					blurredImgData.images{2}.imageName = ...
						[  imgData.images{2}.imageSafeName BLUR_LBL_2 sliceLbl];
					blurredImgData.images{3}.imageName = ...
						[  imgData.images{3}.imageSafeName BLUR_LBL_2 sliceLbl];
                    mlpublish.ImagePublisher.publishImgsCoeffVar(blurredImgData,  aSlice, 'jet', true);
                end
            end
        end
    end
    
    if (WRITE_SCATTERS)
        disp('Plotting 4-Scatters..........');
        imgData.printProps = mlpublish.ScatterPublisher.defaultPrintProps;
        imgData.images{2}.scatter = mlpublish.ScatterPublisher.makeScatterImage(imgData, [1 2]);
        imgData.images{3}.scatter = mlpublish.ScatterPublisher.makeScatterImage(imgData, [1 3]);
    end

    if (WRITE_BLAND_ALTMANS)
        disp('Plotting Bland-Altmans..........');
        imgData.printProps = mlpublish.ScatterPublisher.makePrintProps( ...
            [imgData.images{yIdx}.imageSafeName ' Bland-Altman ' num2str(finalBlur) 'mm'],...
            [imgData.images{yIdx}.imageSafeName ' Bland-Altman ' num2str(finalBlur) 'mm'],...
            ['mean\{' imgData.images{yIdx}.imageName ', ' imgData.images{xIdx}.imageName '\} / (' imgData.images{xIdx}.units ')'], ...
            ['diff\{' imgData.images{yIdx}.imageName ', ' imgData.images{xIdx}.imageName '\} / (' imgData.images{xIdx}.units ')'], ...
            'Legend Labels');
        laifBA = single_patient_voxels_blandaltman(...
            imgData.images{xIdx}.dipImage, imgData.images{yIdx}.dipImage, ...
            xParams, yParams,  ...
            imgData.masks, ...
            ['mean\{' imgData.images{yIdx}.imageName ', ' imgData.images{xIdx}.imageName '\} / (' imgData.images{xIdx}.units ')'], ...
            [     '(' imgData.images{yIdx}.imageName ' - ' imgData.images{xIdx}.imageName ') / (' imgData.images{xIdx}.units ')'],...
            finalBlur,  ...
            [imgData.images{yIdx}.imageSafeName ' Bland-Altman ' num2str(finalBlur) 'mm'], MAX_AMPLITUDE,...
            imgData.printProps)
        imgData.printProps = mlpublish.ScatterPublisher.makePrintProps( ...
            [imgData.images{y2Idx}.imageSafeName ' Bland-Altman ' num2str(finalBlur) 'mm'],...
            [imgData.images{y2Idx}.imageSafeName ' Bland-Altman ' num2str(finalBlur) 'mm'],...
            ['mean\{' imgData.images{y2Idx}.imageName ', ' imgData.images{xIdx}.imageName '\} / (' imgData.images{xIdx}.units ')'], ...
            ['diff\{' imgData.images{y2Idx}.imageName ', ' imgData.images{xIdx}.imageName '\} / (' imgData.images{xIdx}.units ')'], ...
            'Legend Labels');
        mlemBA = single_patient_voxels_blandaltman(...
            imgData.images{xIdx}.dipImage, imgData.images{y2Idx}.dipImage, ...
            xParams, y2Params,  ...
            imgData.masks, ...
            ['mean\{' imgData.images{y2Idx}.imageName ', ' imgData.images{xIdx}.imageName '\} / (' imgData.images{xIdx}.units ')'], ...
            [     '(' imgData.images{y2Idx}.imageName ' - ' imgData.images{xIdx}.imageName ') / (' imgData.images{xIdx}.units ')'],...
            finalBlur,  ...
            [imgData.images{y2Idx}.imageSafeName ' Bland-Altman ' num2str(finalBlur) 'mm'], MAX_AMPLITUDE,...
            imgData.printProps)
        imgData.laifBA = laifBA;
        imgData.mlemBA = mlemBA;
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

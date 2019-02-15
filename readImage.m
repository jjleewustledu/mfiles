%
%  USAGE:  imgDat = readImage(imgDat, imgTag)
%
%          imgDat:		struct containing image data
%          imgTag:		string specifying image to read, or integer index of image
%                       within imgDat.images
%
%          imgDat:		returns updated imgDat
%
%  Created by John Lee on 2008-04-23.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function imgDat = readImage(imgDat, imgTag)
     
	switch (nargin)
		case 2
		otherwise
			error(help('readImage'));
	end
	
	imgIdx = -1;
	switch class(imgTag)
		case 'double'
			imgIdx = imgTag;
		case 'char'
			for i = 1:size(imgDat.images,2)
				if strcmp(imgTag, imgDat.images{i}.imageName) imgIdx = i; end
			end
		otherwise
			error(['readImage:  could not recognize the class of imgTag -> ' class(imgTag)]);
    end
    
	if (-1 == imgIdx) 
        error('readImage:  could not determine imgIdx'); end
	
    switch (lower(imgDat.images{imgIdx}.modality))
		case 'pet'
			folder = [imgDat.basepath pidFolder(imgDat.pid) '/' imgDat.petfolder];
			switch (lower(imgDat.images{imgIdx}.metric))
				case {'ho1','oc1','oo1'}
					filename = [folder filestemPet(imgDat.pid, imgDat.images{imgIdx}.metric) '.4dfp.img'];
					imgDat.images{imgIdx}.dipImage = getDipImg(imgDat, filename);
				case 'cbf'
					filename = [folder filestemPet(imgDat.pid, imgDat.images{imgIdx}.metric) '.4dfp.img'];
					fwhh     = imgDat.images{imgIdx}.fwhh;
					mmppix   = imgDat.images{imgIdx}.mmppix;
					flows    = imgDat.images{imgIdx}.flows;
					imgDat.images{imgIdx}.dipImage = ...
						counts_to_petCbf( ...
							gaussAnisofFwhh(... ...
								getDipImg(imgDat, filename), fwhh, mmppix),  ...
								imgDat.pid);
				case 'cbv'
					filename = [folder filestemPet(imgDat.pid, imgDat.images{imgIdx}.metric) '.4dfp.img'];
					fwhh     = imgDat.images{imgIdx}.fwhh;
					mmppix   = imgDat.images{imgIdx}.mmppix;
					imgDat.images{imgIdx}.dipImage = ...
						counts_to_petCbv( ...
							gaussAnisofFwhh(... ...
								getDipImg(imgDat, filename), fwhh, mmppix), imgDat.pid);
				case 'mtt'
                    error('readImage:  implementation issue:  when to do filtering');
                    
					filecbf  = [folder filestemPet(imgDat.pid, 'cbf') '.4dfp.img'];
					filecbv  = [folder filestemPet(imgDat.pid, 'cbv') '.4dfp.img'];
					fwhh     = imgDat.images{imgIdx}.fwhh;
					mmppix   = imgDat.images{imgIdx}.mmppix;
					flows    = imgDat.images{imgIdx}.flows;
					numer    = counts_to_petCbv( ...
									gaussAnisofFwhh(... ...
										getDipImg(imgDat, filecbv), fwhh, mmppix), imgDat.pid);
					denom    = counts_to_petCbf( ...
									gaussAnisofFwhh(... ...
										getDipImg(imgDat, filecbf), fwhh, mmppix),  ...
										imgDat.pid);
					imgDat.images{imgIdx}.dipImage = ...
                        60 * divideDipImgs(imgDat, numer, denom);	
				case 'oef'
				case 'cmro2'
				otherwise
					error(['readImage:  could not recognize imgDat.images{' num2str(imgIdx) '}.metric -> ' ...
					       lower(imgDat.images{imgIdx}.metric)]);
            end
            
		case 'mr'
			folder = [imgDat.basepath imgDat.pid '/' mrFolderName(imgDat.study)];
			switch (lower(imgDat.images{imgIdx}.processing))
				case 'laif'					
                         if (strcmp('mtt', lower(imgDat.images{imgIdx}.metric)))
                             filename = filenameLaif(imgDat.pid, 'delta');
                             imgDat.images{imgIdx}.dipImage = getDipImg(imgDat, filename);
                             unity = dip_image(ones(imgDat.sizes3d));
                             imgDat.images{imgIdx}.dipImage = ...
                                 divideDipImgs(imgDat, unity, imgDat.images{imgIdx}.dipImage);
                         else
                             filename = filenameLaif(imgDat.pid, imgDat.images{imgIdx}.metric);
                             imgDat.images{imgIdx}.dipImage = getDipImg(imgDat, filename);
                         end
				case 'mlem'
					filename = filenameMlem(imgDat.pid, imgDat.images{imgIdx}.metric);
					imgDat.images{imgIdx}.dipImage = getDipImg(imgDat, filename);
				case {'shin-carroll', 'ssvd','qcbf','qcbv','qmtt'}
                         imgDat.images{imgIdx}.dipImage = getMatImg(imgDat, imgIdx);
				otherwise
					error(['readImage:  could not recognize imgDat.images{' num2str(imgIdx) '}.processing -> '  ...
					       lower(imgDat.images{imgIdx}.processing)]);
               end
		otherwise
			error(['readImage:   could not recognize imgDat.images{' num2str(imgIdx) '}.modality -> ' modality]);
    end


    function dipImg = getDipImg(imgDat, filename)

        disp(['DEBUG:  reading ' filename '..........']);
		dipImg = squeeze( ...
			read4d(filename, 'ieee-be', 'float', imgDat.sizes(1), imgDat.sizes(2), imgDat.sizes(3), 1, 0,0,0));
		
        
    function img = getMatImg(imgDat, imgIdx)
        
        iqCBF = -1; iqCBV = -1;
        load(filenameMat(imgDat.pid));
        disp('image_names:');
        for i = 1:length(image_names)
            if (i < 10) spacer = '      ';
            else        spacer = '     ';
            end
            disp([num2str(i) spacer image_names{i}]);
            if (strcmp('qCBF_nSVD', image_names{i}))
                iqCBF = i; end
            if (strcmp('qCBV_DSC', image_names{i}))
                iqCBV = i; end
        end
        if (iqCBF < 1)
            error('readImage:ParamNotAssigned', 'iqCBF'); end
        if (iqCBV < 1)
            error('readImage:ParamNotAssigned', 'iqCBV'); end
        switch (lower(imgDat.images{imgIdx}.metric))
            case {'cbf','qcbf'}
                img = dip_image(images{iqCBF});
            case {'cbv','qcbv'}
                img = dip_image(images{iqCBV});
            case {'mtt','qmtt'}
                img = divideDipImgs(imgDat, ...
                      dip_image(images{iqCBV}), dip_image(images{iqCBF}));
            otherwise
                error('readImage:UnrecogniaedArgument', ...
                      [imgDat.metric ' was not recognizable']);
        end     
        
            
	function dipImg = divideDipImgs(imgDat, numer, denom)
		        
		numer = squeeze(scrubNaNs(numer));
		denom = squeeze(scrubNaNs(denom));	
        
        small  = denom < (mean(denom) - 2*std(denom));
        denom  = (denom .* ~small) + small;
        dipImg = numer ./ denom;
        neg    = dipImg < 0;
        peaks  = dipImg > (mean(dipImg) + 2*std(dipImg));
        dipImg = dipImg .* (~neg & ~peaks);
		

	
	

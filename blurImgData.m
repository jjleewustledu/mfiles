% blurImgData applies a blurring algorithm to the passed image-data class.  Factory design pattern.
% Only aniso. Gaussian blurring is supported at present.
%
% Instantiation:    outDat = blurImgDataFactory(imgDat, msk)
%
%                   outDat, imgDat:	image-data class as specified by makeImgData
%					msk:  floating-point mask to apply prior to blurring
%
% Created by John Lee on 2008-12-11.
% Copyright (c) 2008 Mallinckrodt Institute of Radiology. All rights reserved.
% Report bugs to <bug.perfusion.neuroimage.wustl.edu@gmail.com>.

function outDat = blurImgData(imgDat, msk)

	ENSURE_DIP = 1;
	
	switch (nargin)
	    case 1
	         assert(isa(imgDat,'struct'), ...
	                'NIL:blurImgData:ctor:TypeErr:unrecognizedType', ...
	                ['type of imgData was unexpected: ' class(imgDat)]);
			msk = ones(size(imgDat.images{1}.dipImage));
			if (ENSURE_DIP)
				msk = dip_image(msk); end
		case 2
			assert(isa(imgDat,'struct'), ...
	                'NIL:blurImgData:TypeErr:unrecognizedType', ...
	                ['type of imgData was unexpected: ' class(imgDat)]);
			for i = 1: length(imgDat.images)
				assert(prod(size(imgDat.images{i}.dipImage)) == prod(size(msk)),  ...
						'NIL:blurImgData:SizeErr:incompatibleSize', ...
						['size of imgDat.images {' num2str(i) '} -> ' num2str(size(imgDat.images{i})) '; '  ...
						 'size of msk               -> ' num2str(size(msk))]);
			end
	    otherwise
	         error('NIL:blurImgData:ctor:PassedParamsErr:numberOfParamsUnsupported', ...
	               help('blurImgData'));
    end

	outDat = imgDat;
	for i = 1:length(outDat.images);
		outDat.images{i}.dipImage = gaussAnisofFwhh(  ...
									imgDat.images{i}.dipImage .* msk, imgDat.images{i}.fwhh, imgDat.images{i}.mmppix)
		if (ENSURE_DIP) 
			outDat.images{i}.dipImage = dip_image(outDat.images{i}.dipImage); end
	end
	 
end


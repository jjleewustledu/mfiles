%
%   binVoxels bins individual voxels from an ImageData object into blocked voxels
%
%	Usage:	imgOut = binVoxels(imgIn, sizesBlock)
%
%           imgIn:     ImageData object containing dipimages to rank 3
%           sizesBlock:  scalar or row vector up to length 3
%           imgIn:     updated ImageData w/ new voxels having mean value of binned imgIn voxels
%
%           imgIn & sizesBlock must have consistent sizes
%
%________________________________________________________________________________

function [imgOut sizeOut] = binVoxels(imgIn, sizesBlock)

	switch (nargin)
		case 2
            if (~isa(imgIn,'dip_image'))
                imgIn = dip_image(imgIn); end
            if (size(size(imgIn),2) ~= size(sizesBlock,2))
                disp('   binVoxels:  image rank and length of block size do not match');
                error(help('binVoxels'));
            end
            switch (size(size(imgIn),2))
                case 1
                    tmp        = newim(size(imgIn,2), 1, 1);
                    tmp(:,0,0) = imgIn;
                    imgIn      = tmp;
                case 2
                    tmp        = newim(size(imgIn,1), size(imgIn,2), 1);
                    tmp(:,:,0) = imgIn;
                    imgIn      = tmp;
                case 3
                otherwise
                    error('   binVoxels:  accepts only images with rank <= 3'); 
            end
            switch (size(sizesBlock,2))
                case 1
                    sizesBlock = [sizesBlock 1 1];
                case 2
                    sizesBlock = [sizesBlock(1) sizesBlock(2) 1];
                case 3
                otherwise
                error(help('binVoxels')); 
            end
		otherwise
			error(help('binVoxels'));
	end
	disp('binVoxels:  version from 2008mar28');	
	
	disp(['binVoxels:  binning data in ' num2str(sizesBlock(1)) ' X ' ...
										 num2str(sizesBlock(2)) ' X ' ...
										 num2str(sizesBlock(3)) ' blocks']);
    disp('            please wait ....................................');

	sizeIn  = size(imgIn);
	sizeOut = floor(sizeIn ./ sizesBlock);
	imgOut  = newim(sizeOut);

    % row-major ordering for dipimage
    
    tic
    for z = 0:(sizeOut(3) - 1)
        for y = 0:(sizeOut(2) - 1)
            for x = 0:(sizeOut(1) - 1)
                z2 = z*sizesBlock(3);
                y2 = y*sizesBlock(2);
                x2 = x*sizesBlock(1);
                imgOut(x,y,z) = sum( ...
                    imgIn(x2:(x2 + sizesBlock(1)-1), y2:(y2 + sizesBlock(2)-1), z2:(z2 + sizesBlock(3)-1)) ...
                    )/(prod(sizesBlock));     
            end 
        end
    end
	toc
    

		
		

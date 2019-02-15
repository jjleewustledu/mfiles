function imgOut = flip4d(imgIn, axis, permuteOrder)
%% FLIP4D flips input images from -x to x, -y to y or -z to z, or applies permute
%         input images may be Matlab native arrays or dip_image objects
%         output images have same type as input images
%
%   Usage:  imgOut = flip4d(imgIn, axis, permuteOrder)
%           axis:    axis along which data is flipped, 'x', 'y', 'z'; transpose when 't'
%                    applied in order right to left, as operators, when multiple 'abcd'
%                    e.g., performs d, then c, then b & finally a
%           permuteOrder:   used for any transpose request, given to permute; defaults to [2 1 3 4]
%
%   See also:  flipdim, permute

% check inputs
assert(islogical(imgIn) || isnumeric(imgIn) || isa(imgIn, 'dip_image') || isa(imgIn, 'mlfourd.INIfTI'));
classImgIn  = class(imgIn);
tensOrder   = size(size(imgIn), 2);
assert(ischar(axis));
if (~exist('permuteOrder','var'))
    permuteOrder = [2 1 3 4];
end

% use recursion for multiple axis flips
if (   length(axis) > 1)
    imgTmp = flip4d(imgIn,  axis(2:length(axis)));
    imgOut = flip4d(imgTmp, axis(1));
else

    % convert everything to internal, double objects of tensor-order 4
    switch tensOrder
        % should not be 1 for matlab numericals
        case 2
            dbleTo4          = zeros(size(double(imgIn)));
            dbleTo4(:,:,1,1) = double(imgIn);
        case 3
            dbleTo4          = zeros(size(double(imgIn)));
            dbleTo4(:,:,:,1) = double(imgIn);
        case 4
            dbleTo4          = double(imgIn);
        otherwise
            error('mfiles:InputParamsErr', ...
                 ['flip4d does not supports objects with tensor-order ' num2str(tensOrder)]); 
    end

    % make output the same class as the input, but with tensor-order 4
    if (strcmp('dip_image', classImgIn))
        xdim = 2; ydim = 1;
    else
        xdim = 1; ydim = 2;
    end
    switch (axis)
        case 'x'
            imgOut = flipdim(dbleTo4, xdim);
        case 'y'
            imgOut = flipdim(dbleTo4, ydim);
        case 'z'
            imgOut = flipdim(dbleTo4, 3);
        case {'t' '+'} % transpose
            imgOut = permute(dbleTo4, permuteOrder);
        otherwise
            error('mfiles:InputParamsErr', ['flip4d did not recognize axis -> ' axis]);
    end
    switch (classImgIn)
        case 'integer'
            imgOut = integer(imgOut);
        case 'int8'
            imgOut = int8(imgOut);
        case 'uint8'
            imgOut = uint8(imgOut);
        case 'int16'
            imgOut = int16(imgOut);
        case 'uint16'
            imgOut = uint16(imgOut);
        case 'int32'
            imgOut = int32(imgOut);
        case 'uint32'
            imgOut = uint32(imgOut);
        case 'int64'
            imgOut = int64(imgOut);
        case 'uint64'
            imgOut = uint64(imgOut);
        case 'double'
        case {'float', 'single'}
            imgOut = single(imgOut);
        case 'dip_image'
            imgOut = dip_image(imgOut);
        case mlfourd.NIfTI.NIFTI_SUBCLASS
            imgIn.img = imgOut;
            imgOut    = imgIn;
        otherwise
            error('mfiles:InputParamsErr', ['flip4d did not recognize class -> ' class(imgIn)]);
    end
end % recursion

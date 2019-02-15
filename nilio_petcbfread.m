%NILIO_PETCBFREAD reads PET CBF data, as int16, from file
%
% SYNOPSIS:
%  mont = nilio_petcbfread(NumSlices, filename)
%  mont = nilio_petcbfread(NumSlices, filename, mask)
%
% PARAMETERS:
%  mont      -> montage of size MontRows x MontCols
%  NumSlices -> from axial PET sections
%  mask      -> image pixels from the slice-montage to be kept (optional)

function mont = nilio_petcbfread(NumSlices, filename, mask)

% private parameters
Verbose = 0;
PixelBytes = 2;
Dim = 256;
StructImg = [Dim,Dim];
if (NumSlices < 1) NumSlices = 8; end
%%%disp(['   NumSlices -> ' num2str(NumSlices)]);

% read raw binary data
mont = newim(Dim*4, Dim*2);
tmp  = newim(Dim, Dim);
image_out = newim(Dim, Dim, NumSlices); % expected by function
% dip_image
[fid, message] = fopen(filename, 'r', 'ieee-be'); % data was originally stored as
% big-endian int16
if (fid < 0)
    disp(['fid -> ' num2str(fid) ', message -> ' message]);
end

for iSlices = 0:NumSlices-1
    disp(['freading iSlice -> ' num2str(iSlices)]);
    imgraw = fread(fid, StructImg, 'int16');
    image_out(:,:,NumSlices-1-iSlices) = nil_rotate(dip_image(imgraw, 'uint16'),3.0);
end
mont = arrangeslices(image_out, 4)*mask/max(mask);

fclose(fid);



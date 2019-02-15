%NILIO_PETREAD2 reads raw PET perfusion data from file
%
% SYNOPSIS:
%  img2d = nilio_petread3(NumSlices, filename, mask)
%
% PARAMETERS:
%  filename: string with name of file
%  mask:     boolean image-mask, optional
%
% USES:  nil_rotate, dip_image
%
% $Author: jjlee $
% $Date: 2003/11/12 08:25:08 $
% $Version$
% $Source: /cygdrive/c/data/home/dip_local/RCS/nilio_petread2.m,v $




function mont = nilio_petread3(NumSlices, filename, mask)

  % private parameters
  VERBOSE = 0;
  PixelBytes = 2;
  Dim = 256; 
  StructImg = [Dim,Dim];
  if (NumSlices < 1) NumSlices = 8; end
  % disp(['   NumSlices -> ' num2str(NumSlices)]);
  
  % read raw binary data
  mont  = newim(Dim*4, Dim*2);
  tmp   = newim(Dim,   Dim);
  imout = newim(Dim,   Dim, NumSlices); % expected by 
                                        % dip_image
					
  % data was originally stored as big-endian int16
  [fid, message] = fopen(filename, 'r', 'ieee-be'); 
  if (fid < 0)
      disp(['fid -> ' num2str(fid) ', message -> ' message]);
  end

  for iSlices = 0:NumSlices-1
    % disp(['freading iSlice -> ' num2str(iSlices)]);
    imgraw = fread(fid, StructImg, 'single');
    imout(:,:,iSlices) = nil_rotate(dip_image(imgraw, 'single'),1.0);
  end
  
  if (2 == nargin)
    mont = arrangeslices(imout, 4);
  elseif (3 == nargin)
    mont = arrangeslices(imout, 4)*mask/max(mask);
  else
    error('must provide 2 or 3 arguments')
  end

  fclose(fid);



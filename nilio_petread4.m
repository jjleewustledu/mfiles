%NILIO_PETREAD4 reads PET perfusion data formatted via T. O. Videen's
%               metcompute routines
%
% SYNOPSIS:
%  montage = nilio_petread4(filename, piover2s)
%
% PARAMETERS:
%  filename: string with name of file
%  piover2s: integer to multiply pi/2
%
% USES:  
%  nil_rotate, dip_image
%
% $Author: jjlee $
% $Date: 2003/11/12 08:25:08 $
% $Version$
% $Source: /cygdrive/c/data/home/dip_local/RCS/nilio_petread2.m,v $




function mont = nilio_petread4(filename, piover2s)

  PixelBytes = 2;
  Dim = 256; 
  StructImg = [Dim,Dim];
  NumSlices = 8;
  
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
    imgraw = fread(fid, StructImg, 'single');
    imout(:,:,iSlices) = nil_rotate(dip_image(imgraw, 'single'), piover2s);
  end
  mont = arrangeslices(imout, 4);

  fclose(fid);



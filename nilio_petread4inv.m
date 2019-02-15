%NILIO_PETREAD4INV reads PET perfusion data formatted via T. O. Videen's
%                 metcompute routines.  Adapted for unusual orientation of pt7's PET CBV.
%
% SYNOPSIS:
%  montage = nilio_petread4inv(filename, piover2s)
%
% PARAMETERS:
%  filename: string with name of file
%  piover2s: integer to multiply pi/2
%
% USES:  
%  nil_rotate, dip_image
%
% NOTES:
%  All the .ima files from np287/vc* are from a Siemens Magnetom Vision.
%  They appear to be in Siemens-modified SPI format.  
%
%  The .ima files have 137,216 bytes corresponding to 6144*char header information 
%  followed by 256*256*int16 image information.
%
%  D. Clunie has a unix app. that will convert proprietary formats to DICOM,
%  which may be useful since Matlab will directly read DICOM.  
%  Cf. http://www.dclunie.com/medical-image-faq/html/
%
%  John Lee, Mar-Jun 2003.  Currently supporting only the
%  Siemens-modified SPI format, stored as big-endian int16.  
%  Silently discarding SPI header data.




function mont = nilio_petread4inv(filename, piover2s)

% private parameters
Verbose = 0;
PixelBytes = 2;
Dim = 256; 
StructImg = [Dim,Dim];
NumSlices = 8; 

% read raw binary data
  mont = newim(Dim*4, Dim*2);
  tmp  = newim(Dim, Dim);
  image_out = newim(Dim, Dim, NumSlices); % expected by function
                                          % dip_image
  [fid,message] = fopen(filename, 'r', 'ieee-be'); % data was originally stored as
                                                   % big-endian int16
  if (fid < 0)
      disp(['fid -> ' num2str(fid) ', message -> ' message]);
  end

  for iSlices = 0:NumSlices-1
    imgraw = fread(fid, StructImg, 'single'); % int16?
    image_out(:,:, NumSlices - 1 - iSlices) = nil_rotate(dip_image(imgraw, ...
						  'single'), piover2s); % uint16?
  end
  mont = arrangeslices(image_out, 4);

  fclose(fid);



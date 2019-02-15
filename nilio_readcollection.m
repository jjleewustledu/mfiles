%NILIO_READCOLLECTION  read raw data from a file, up to 3D
%
% SYNOPSIS:
%  image_out = nilio_readcollection(filename, type, dim1, dim2, dim3)
%
% NOTES:
%  dim1, dim2, dim3 - integers expected by dipimage function newim
%  type             - string identifying the data type
%
%  possible types...
%     bin          <-> bin8, bin16, bin32
%     uint8
%     uint16
%     uint32       <-> uint
%     sint8        <-> int8
%     sint16       <-> int16
%     sint32       <-> int, int32
%     sfloat       <-> float, single
%     dfloat       <-> double
%     scomplex
%     dcomplex     <-> complex
%
%  typically...
%  - 2D images have 2x4 montage format;
%  - 3D images simply span another dimension with 80 x times
%
% PARAMETERS:
%  filename - string with name of file
%
% $Author$
% $Date$
% $Revision$
% $Source$




function image_out = nilio_readcollection(filename, type, Dim1, Dim2, Dim3)

  % private parameters
  Verbose = 0;
  StructImg = [Dim1, Dim2];
  ByteOrder = 'native';

  % check for silly inputs
  if (strcmp('', filename)) error('oops... missing filename'); end
  if (~strcmp('bin', type) & ... 
      ~strcmp('bin8', type) & ...
      ~strcmp('bin16', type) & ...
      ~strcmp('bin32', type) & ...
      ~strcmp('uint8', type) & ...      
      ~strcmp('uint16', type) & ...      
      ~strcmp('uint32', type) & ...      
      ~strcmp('uint', type) & ...      
      ~strcmp('sint8', type) & ...      
      ~strcmp('int8', type) & ...      
      ~strcmp('sint16', type) & ...      
      ~strcmp('int16', type) & ...      
      ~strcmp('sint32', type) & ...      
      ~strcmp('int', type) & ...      
      ~strcmp('int32', type) & ...      
      ~strcmp('sfloat', type) & ...      
      ~strcmp('float', type) & ...      
      ~strcmp('single', type) & ...      
      ~strcmp('dfloat', type) & ...      
      ~strcmp('double', type) & ...      
      ~strcmp('scomplex', type) & ...      
      ~strcmp('dcomplex', type) & ...      
      ~strcmp('complex', type) ...
      ) error('oops... unrecognized data type'); end
  if (Dim1 < 0) error('oops... Dim1 < 0'); end
  if (Dim2 < 0) error('oops... Dim2 < 0'); end
  if (Dim3 < 0) error('oops... Dim3 < 0'); end
  
  % read raw binary data
  image_out = newim(Dim2, Dim1, Dim3);   % expected by function dip_image; 
                                         % Dims may be singletons
  [fid, message] = fopen(filename, 'r', ByteOrder);
  if (fid < 0)
      disp(['fid -> ' num2str(fid) ', message -> ' message]);
  end
  for k = 0:Dim3-1
    %%%disp(['   freading 3rd index -> ' int2str(k)]);
    try
      image_raw = fread(fid, StructImg, type);
    catch
      error('   sorry... fread failed');
    end
    try
      image_out(:,:,k) = dip_image(image_raw, type);
    catch
      error('oops... dip_image conversion failed');
    end
  end
  fclose(fid);

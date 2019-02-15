%NILIO_READICA reads floating-point data in Avi Snyder's 4dfp-format
%
% SYNOPSIS:
%  image_out = nilio_readICA(filename, endian, type, dim1, dim2, dim3, dim4, offset4)
%
%  possible types...
%     bin          <-> bin8, bin16, bin32
%     sfloat       <-> float, single
%     dfloat       <-> double
%     scomplex
%     dcomplex     <-> complex
%
% PARAMETERS:
%  filename               - string with name of file
%  endian                 - native, ieee-le, or ieee-be
%  type                   - string identifying the data type
%  dim1, dim2, dim3, dim4 - integers expected by dipimage function newim
%  offset4                - number of dim4 frames to skip
%  image_out              - double array sized NUM_TIME (x) NUM_PIXELS
%
% $Author$
% $Date$
% $Revision$
% $Source$

function image_out = nilio_readICA(filename, endian, type, Dim1, Dim2, Dim3, Dim4, Offset4)
  
  disp('entering nilio_readICA');
  image_out = [1 2 3];
  
  % private parameters
  Verbose = 0;

  % check for silly inputs
  if (strcmp('', filename)) error('nilio_read4d:  oops... missing filename'); end
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
      ) error('nilio_read4d:  oops... unrecognized data type'); end
  if (Dim1 < 0) error('nilio_read4d:  oops... Dim1 < 0'); end
  if (Dim2 < 0) error('nilio_read4d:  oops... Dim2 < 0'); end
  if (Dim3 < 0) error('nilio_read4d:  oops... Dim3 < 0'); end
  if (Dim4 < 0) error('nilio_read4d:  oops... Dim4 < 0'); end
  if (Offset4 < 0) error('nilio_read4d:  oops... Offset4 < 0'); end
  
  StructImg = Dim1*Dim2*Dim3;
  disp(['StructImg -> ' num2str(StructImg)]);
  image_out = zeros(Dim4, Dim1*Dim2*Dim3);
  disp(['prod(size(image_out)) -> ' num2str(prod(size(image_out)))]);
  
  fid = fopen(filename, 'r', endian);
  disp(['opened file ' filename]);
  
  if (Offset4 == 1)
      disp(['   skipping indices -> (:,:,:,0)']);
  elseif (Offset4 > 1)
      disp(['   skipping indices -> (:,:,:,0:' int2str(Offset4-1) ')']);
  end  
  for j0 = 0:Offset4-1         
      try
          image_raw = fread(fid, StructImg, type);
      catch
          error('nilio_read4d:  oops... fread to skip elements failed');
      end
  end
  
  % collect the image
  for j = 0:Dim4-1
      disp(['   freading indices -> (:,:,:,' int2str(Offset4+j) ')']);
      try
          image_raw = fread(fid, StructImg, type);
          image_out(j+1,:) = double(image_raw);
      catch
          error('nilio_read4d:  oops... fread to image_out failed');
      end
  end
  
  fclose(fid);

%NILIO_READICAWINDOW reads floating-point data in Avi Snyder's 4dfp-format
%
% SYNOPSIS:
%  image_out = nilio_readICAWindow(filename, endian, type, dim1, dim2, dim3, select4, offset3, select3, offset4)
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
%  dim1, dim2, dim3, select4 - integers expected by dipimage function newim
%  offset4                - number of select4 frames to skip
%  image_out              - double array sized NUM_TIME (x) NUM_PIXELS,
%                           so-called X11 format expected by DTU_TOOLBOX
%
% $Author$
% $Date$
% $Revision$
% $Source$

function image_out = nilio_readICAWindow(filename, endian, type, Dim1, Dim2, Dim3, Select4, Offset3, Select3, Offset4)

  disp('entering nilio_read4dwindow');

  % private parameters
  Verbose = 0;

  % check for silly inputs
  if (strcmp('', filename)) error('nilio_read4dwindow:  oops... missing filename'); end
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
      ) error('nilio_read4dwindow:  oops... unrecognized data type'); end
  if (Dim1 < 0) error('nilio_read4dwindow:  oops... Dim1 < 0'); end
  if (Dim2 < 0) error('nilio_read4dwindow:  oops... Dim2 < 0'); end
  if (Dim3 < 0) error('nilio_read4dwindow:  oops... Dim3 < 0'); end  
  if (Offset3 < 0) error('nilio_read4dwindow:  oops... Offset3 < 0'); end
  if (Select3 < 0) error('nilio_read4dwindow:  oops... Select3 < 0'); end
  if (Offset3 + Select3 > Dim3) error(['nilio_read4dwindow:  oops... Dim3 = ' num2str(Dim3) ', but Offset3 = ' num2str(Offset3) ' and Select3 = ' num2str(Select3) ]); end
  if (Offset4 < 0) error('nilio_read4dwindow:  oops... Offset4 < 0'); end
  if (Select4 < 0) error('nilio_read4dwindow:  oops... Select4 < 0'); end
  
  StructImg = Dim1*Dim2;
  image_out = zeros(Select4, Dim1*Dim2*Select3); 
  accum     = zeros(Dim1*Dim2, Select3);
  
  [fid, message] = fopen(filename, 'r', endian);
  if (fid < 0)
    disp(['fid -> ' num2str(fid) ', message -> ' message]);
  end

  if (Offset4 == 1)
      disp(['   skipping indices -> (:,:,:,0)']);
  elseif (Offset4 > 1)
      disp(['   skipping indices -> (:,:,:,0:' int2str(Offset4-1) ')']);
  end  
  for j0 = 0:Offset4-1
      for k = 0:Dim3-1          
          try
              image_raw = fread(fid, StructImg, type);
          catch
              error('nilio_read4dwindow:  oops... fread to skip Offset4-elements failed');
          end
      end
  end

  % collect the image
  Remainder = Dim3 - Select3 - Offset3;
  for j = 0:Select4-1
      for k0 = 0:Offset3-1
          try
              image_raw = fread(fid, StructImg, type);
          catch
              error('nilio_read4dwindow:  oops... fread to skip Offset3-elements failed');
          end
      end
      if (Select3 == 1)
        disp(['   freading indices -> (:,:,' int2str(Offset3) ',' int2str(Offset4+j) ')']);
      elseif (Select3 > 1)
        disp(['   freading indices -> (:,:,' int2str(Offset3) ':' int2str(Offset3+Select3-1) ',' int2str(Offset4+j) ')']);
      end
      for k = 0:Select3-1
          try
              image_raw = fread(fid, StructImg, type);
              accum(:,k+1) = image_raw; 
          catch
              error('nilio_read4dwindow:  oops... fread to accum failed');
          end
      end
      for k2 = 0:Remainder-1
          try
              image_raw = fread(fid, StructImg, type);
          catch
              error('nilio_read4dwindow:  oops... fread to skip Remainder-elements failed');
          end
      end
      try
          disp(['   accum has ' num2str(prod(size(accum))) ' elements']);
          image_out(j+1,:) = reshape(accum, 1, prod(size(accum)));
      catch
          error(['nilio_read4dwindow:  oops... assignment of image_out at j -> ' num2str(j) ' failed']);
      end
  end
  
  fclose(fid);

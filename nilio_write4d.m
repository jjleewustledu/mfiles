% NILIO_WRITE4DFP writes 4dfp objects from Matlab to file systems
%
% USAGE: nilio_write4dfp(object, endian, filename)
%
% SEE ALSO:
%     nilio_read4dfp
%
% PARAMETERS:
%  object   - 4dfp object from Matlab
%  endian   - native, ieee-le, or ieee-be
%  filename - string with name of file
%
% $Author: jjlee $
% $Date: 2003/10/23 03:27:30 $
% $Revision: 1.2 $
% $Source: /cygdrive/c/local/dipimage-23jun2003/local/RCS/nilio_writecollection.m,v $


function nilio_write4d(object, type, endian, filename)

  sizes      = size(object);
  size_sizes = size(sizes);
  rank       = size_sizes(2);
  
  if (rank ~= 2 & rank ~= 3 & rank ~= 4 & rank ~= 5) 
      error(['oops... passed object has unsupported rank -> ' num2str(rank)]); 
  end
  
  % check for silly inputs 
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
  if (~strcmp('ieee-be', endian) & ... 
      ~strcmp('ieee-le', endian) & ...
      ~strcmp('native', endian) ...      
      ) error('oops... unrecognized data endian'); end
  if (strcmp('', filename)) 
      error('oops... missing filename'); end

  subobject = newim(sizes(1), sizes(2));

  fid = fopen(filename, 'w+', endian);
  
  switch rank
      case 2
          subobject(:,:) = object(:,:);
          double_subobject = double(subobject); 
          try
              fwrite(fid, double_subobject', type);   % NB transpose, described in nilio_read4dfp
          catch
              error(['oops... nilio_write4d failed for ' filename]);
          end   
      case 3
          for k = 0:sizes(3)-1
              subobject(:,:) = object(:,:,k);
              double_subobject = double(subobject); 
              try
                  fwrite(fid, double_subobject', type);   % NB transpose, described in nilio_read4dfp
              catch
                  error(['oops... nilio_write4d failed for ' filename]);
              end   
          end
      case 4
          for j = 0:sizes(4)-1
              for k = 0:sizes(3)-1
                  subobject(:,:) = object(:,:,k,j);
                  double_subobject = double(subobject); 
                  try
                      fwrite(fid, double_subobject', type);   % NB transpose, described in nilio_read4dfp
                  catch
                      error(['oops... nilio_write4d failed for ' filename]);
                  end   
              end
          end
      case 5
          for j = 0:sizes(4)-1
              for k = 0:sizes(3)-1
                  subobject(:,:) = object(:,:,k,j,0);
                  double_subobject = double(subobject); 
                  try
                      fwrite(fid, double_subobject', type);   % NB transpose, described in nilio_read4dfp
                  catch
                      error(['oops... nilio_write4d failed for ' filename]);
                  end   
              end
          end
      otherwise
          error(['nilio_write4d does not support writing arrays with rank -> ' rank]);
  end
  
  disp(['nilio_write4d successfully wrote a rank-' num2str(rank) ' object of type ' type ' and endian ' endian '\nto file ' filename]);
  fclose(fid);
  

  

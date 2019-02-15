%NILIO_WRITEASCII writes floating-point data in Larry Bretthorst's 
%                 ascii format
%
% SYNOPSIS:
%  nilio_writeAscii(filename, 4dfpObject)
%
% NOTES:
%  the original 4dfp-object should be in radiologic convention 
%  when viewed with DIPimage
%
% PARAMETERS:
%  filename   - string with name of file
%  4dfpObject - 4D matlab or dipimage object
%
% $Author$
% $Date$
% $Revision$
% $Source$

function nilio_writeAscii(fourdfpObject, filename)
  
  % private parameters
  Verbose = 0;

  % check for silly inputs
  if (strcmp('', filename)) error('nilio_read4d:  oops... missing filename'); end
  if (prod(size(fourdfpObject)) < 1) error('nilio_read4d:  oops... prod(size(4dfpObject)) < 1'); end
  
  %--------------------------- do business --------------------------------
  
  dims = size(fourdfpObject);
  fourdfpDip = double(fourdfpObject);
  count = 0;
  
  fid = fopen(filename, 'w', 'native');
  for t = 1:dims(4)
      for z = 1:dims(3)
          for x = 1:dims(1)
              for y = 1:dims(2)
                  
                  % preserve the ordering used by dipimage
                  accum = fprintf(fid, '%12.4f\n', fourdfpDip(y,x,z,t));
                  count = count + accum;
              end
          end
      end
  end
  fclose(fid);
  
  disp([num2str(count) ' bytes written to file ' filename]);



%NIL_ROTATION transforms raw image data read from Siemens-modified SPI
%             format so that matlab and dipimage image objects are
%             displayed/oriented per radiological convention.
%
% SYNOPSIS:
%  matout = nilio_rotation(matin)
%
% PARAMETERS:
%  matin, matout are dipimage objects
%
% SEE ALSO:  
%  rotation (dipimage)

function matout = nil_rotate(matin,timesPI2)
  VERBOSE = 0;
  PI2 = 1.5707963267948966192313216916398;
  m = nil_magic;
  matout = newim(m.Dim1, m.Dim2);
  matout = rotation(matin, timesPI2*PI2, 3, 'bspline', 'zero');
  if VERBOSE
    disp('nil_rotation size(matout) ->');
    size(matout);
  end
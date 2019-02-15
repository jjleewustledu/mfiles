%NIL_IMGORDER transforms raw image data read from Siemens-modified SPI
%             format so that matlab and dipimage image objects are
%             displayed/oriented per radiological convention.
%
% SYNOPSIS:
%  matout = nilio_imgorder(matin)
%
% PARAMETERS:
%  matin, matout are matlab data matrices

function matout = nil_imgorder(matin)

matout = matin;
error('Prior use of this function may be the source of bugs for descendent applications';

%  The following may be the wrong prescription to use.
%  This may be the source of bugs for descendent applications.
%  matout = matin';
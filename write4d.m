%WRITE4DFP integrates into the dipimage GUI & writes 4dfp objects from Matlab to file systems
%
% SYNOPSIS:
%  write4d(image, datatype, endian, filename)
%
% SEE ALSO:
%  writecollections
%  nilio_write4dfp
%
% $Author: jjlee $
% $Date: 2003/10/23 03:24:12 $
% $Revision: 1.1 $
% $Source: /cygdrive/c/data/home/dip_local/RCS/writecollection.m,v $

% ________________________________________________________________________________________
% (C) Copyright 1999-2002               Pattern Recognition Group
%     All rights reserved               Faculty of Applied Physics
%                                       Delft University of Technology
%                                       Lorentzweg 1
%                                       2628 CJ Delft
%                                       The Netherlands
%
% Cris Luengo, June 2000.
% January 2002:  Changed compression default to 1 (BR)
% February 2002: Removed static list of file formats.
% July 2002:     Allowing color images as input. This function now substitutes READCOLORIM.
%                Using new DIPIO_IMAGEWRITECOLOUR function.
%                ICS version 2 is now the default (i.e. the 1-file format).

function out = write4d(varargin)
  
  possTypes = {'bin', 'bin8', 'bin16', 'bin32', 'uint8', 'uint16', 'uint32', 'uint', ...
	       'sint8', 'int8', 'sint16', 'int16', 'sint32', 'int', 'int32', 'sfloat', ...
	       'float', 'single', 'dfloat', 'double', 'scomplex', 'dcomplex', 'complex'};
   
  possEnds = {'native', 'ieee-le', 'ieee-be'};

  d = struct('menu','File I/O',...
	     'display','Write 4D data',...
	     'inparams',struct(...
		 'name',       {'image_in',             'datatype',   'endian','filename'},...
		 'description',{'4D object to write',   'DataType',   'Endian','Name of the file to write'},...
		 'type',       {'image',                'option',     'option',  'outfile'},...
		 'dim_check',  {0,                      0,            0,         0},...
		 'range_check',{[],                     possTypes,    possEnds,'*.*'},...
		 'required',   {1,                      0,            0,         1},...
		 'default',    {'ans',                  'single',    'ieee-be',  ''}...
		 )...
	     );

  if nargin == 1
    s = varargin{1};
    if ischar(s) & strcmp(s,'DIP_GetParamList')
      out = d;
      return
    end
  end

  try
    [image_in, datatype, endian, filename] = getparams(d,varargin{:});
  catch
    if ~isempty(paramerror)
      error(paramerror)
    else
      error(firsterr)
    end
  end

  try
    nilio_write4d(image_in, datatype, endian, filename);
  catch
    error('oops... nilio_write4dfp failed')
  end


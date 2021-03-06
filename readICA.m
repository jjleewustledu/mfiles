%READICA integrates into the dipimage GUI & reads 4dfp-formatted data files
%
% SYNOPSIS:
%  image_out = read4dfp(varargin)
%
% SEE ALSO:
%  readcollection
%  nilio_readICA
%
% NOTES:
%  Reads 4dfp data according to function nilio_readICA.
%  Derived from READIM and readcollection.   
%
% $Author: jjlee $
% $Date: 2003/11/12 09:08:05 $
% $Revision: 1.3 $
% $Source: /cygdrive/c/data/home/dip_local/RCS/readcollection.m,v $

% _____________________________________________________________________
% (C) Copyright 1999-2002               Pattern Recognition Group
%     All rights reserved               Faculty of Applied Physics
%                                       Delft University of Technology
%                                       Lorentzweg 1
%                                       2628 CJ Delft
%                                       The Netherlands
%
% Cris Luengo, June 2000.
% 17 December 2001: Using MATLAB's IMREAD if dipIO cannot read the file.
% February 2002: removed static list of file formats.

% ________________________________________________________________
% (C) Copyright 2003                    Neuroimaging Laboratory
%     All rights reserved               Mallinckrodt Institute of 
%                                       Radiology
%                                       4525 Scott Ave, Box 8225
%                                       St. Louis, MO  63110
%
% John Lee, June 2003: Implemented basic functions for reading MR files
% generated by Siemens Magnetom Vision systems (SPI native format)
% Oct 2004: Implemented support for Avi Snyder's 4dfp format

function image_out = readICA(varargin)

  possTypes = {'bin', 'bin8', 'bin16', 'bin32', 'uint8', 'uint16', 'uint32', 'uint', ...
	       'sint8', 'int8', 'sint16', 'int16', 'sint32', 'int', 'int32', 'sfloat', ...
	       'float', 'single', 'dfloat', 'double', 'scomplex', 'dcomplex', 'complex'};
   
  possEnds = {'native', 'ieee-le', 'ieee-be'};
  
  d = struct('menu','File I/O',...
	     'display','Read 4D data',...
	     'inparams',struct(...
                   'name',       {'filename',                 'endian', 'datatype', 'dim1',            'dim2',            'dim3',            'dim4',            'offset3',           'select3',                'offset4'},...
			       'description',{'Name of the file to open', 'Endian', 'Datatype', 'Size of 1st Dim', 'Size of 2nd Dim', 'Size of 3rd Dim', 'Size of 4th Dim', 'Offset of 3rd Dim', 'Selection from 3rd Dim', 'Offset of 4th Dim'},...
			       'type',       {'infile', 'option', 'option',   'array', 'array', 'array', 'array', 'array', 'array', 'array'},...
			       'dim_check',  {0,         0,        0,          0,       0,       0,       0,       0,       0,       0},...
			       'range_check',{'*.*',     possEnds, possTypes, 'N+',    'N+',    'N+',    'N+',    'N',     'N',     'N'},...
			       'required',   {1,         0,        0,          0,       0,       0,       0,       0,       0,       0},...
			       'default',    {'',       'native', 'single',    256,     256,     32,      1,       0,       0,       0} ),...
	     'outparams',struct(...
                'name',{'image_out'},...
				'description',{'Output image'},...
				'type',{'array'}...
				)...
	     );
  if nargin == 1
    s = varargin{1};
    if ischar(s) & strcmp(s,'DIP_GetParamList')
      image_out = d;
      return
    end
  end
  
  try
    [filename, endian, datatype, dim1, dim2, dim3, dim4, offset3, select3, offset4] = getparams(d,varargin{:});
  catch
    if ~isempty(paramerror)
      error(paramerror)
    else
      error(firsterr)
    end
  end  
  
  try
    if (select3 == 0 & offset3 == 0)
        %disp('1st branch');
        arr = nilio_readICA(filename, endian, datatype, dim1, dim2, dim3, dim4, offset4);
        image_out = sum(arr, 2);
    else
        %disp('2nd branch');
        arr = nilio_readICAWindow(filename, endian, datatype, dim1, dim2, dim3, dim4, offset3, select3, offset4);
        image_out = sum(arr, 2);
    end
  catch
    error('sorry...  readICA failed')
  end
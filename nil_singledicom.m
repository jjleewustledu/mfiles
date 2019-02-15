%NIL_SINGLEDICOM integrates into the dipimage GUI & reads dicom data from files
%
% SYNOPSIS:
%  metadata = nil_singledicom(varargin)
%
% SEE ALSO:
%
% NOTES:
%   
% $Author: jjlee $
% $Date: 2004/06/15 00:11:41 $
% $Revision: 1.1 $
% $Source: /cygdrive/c/local/src/mfiles/RCS/nil_singledicom.m,v $

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
% (C) Copyright 2004                    Neuroimaging Laboratory
%     All rights reserved               Mallinckrodt Institute of 
%                                       Radiology
%                                       4525 Scott Ave, Box 8225
%                                       St. Louis, MO  63110
%
% John Lee, June 2004: Implemented basic functions for reading single DICOM files

function metadata = nil_singledicom(varargin)
  
  % setup the dipimage GUI
  
  d = struct('menu','NIL Functions','display','Read single DICOM file','inparams',...
         struct('name',       {'filename'},...
			    'description',{'filename:'},...
			    'type',       {'infile'},...
			    'dim_check',  {0},...
			    'range_check',{'*.*'},...
			    'required',   {1},...
			    'default',    {''}...
         )...
     );
  if nargin == 1
    s = varargin{1};
    if ischar(s) & strcmp(s,'DIP_GetParamList')
      metadata = d;
      return
    end
  end
  
  % check that input parameters are sane
  
  try
    [filename] = getparams(d,varargin{:});
  catch
    if ~isempty(paramerror)
      error(paramerror)
    else
      error(firsterr)
    end
  end
  
  % =============
  % function body
  % =============
  
  try
    image = dicomread(filename);
    imview(image,[]);
    metadata = dicominfo(filename)
  catch
    error('sorry...  nil_singledicom failed')
  end
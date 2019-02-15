%NIL_WRITEMONTAGEDICOM integrates into the dipimage GUI & reads dicom data from files
%
% SYNOPSIS:
%  returnValue = nil_writemontagedicom(varargin)
%
% SEE ALSO:
%
% NOTES:
%   
% $Author: jjlee $
% $Date: 2004/06/15 00:08:26 $
% $Revision: 1.1 $
% $Source: /cygdrive/c/local/src/mfiles/RCS/nil_writemontagedicom.m,v $

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

function returnValue = nil_writemontagedicom(varargin)
  
  % setup the dipimage GUI
  
  d = struct('menu','NIL Functions','display','Write a montage to a DICOM file','inparams',...
         struct('name',       {'dirname',    'filenamePrefix',   'darray'},...
			    'description',{'dir. name:', 'filename prefix:', 'dipimage object:'},...
			    'type',       {'string',     'string',           'image'},...
			    'dim_check',  {0,            0,                  []},...
			    'range_check',{'*',          '*',                []},...
			    'required',   {1,            1,                  1},...
			    'default',    {'T:\',        '',                 'ans'}...
         ),...
         'outparams',...
         struct('name',       {'returnValue'},...
				'description',{'return value:'},...
				'type',       {'array'}...
				)...
      );
  if nargin == 1
     s = varargin{1};
     if ischar(s) & strcmp(s,'DIP_GetParamList')
         returnValue = d;
         return
     end
  end
  
  % check that input parameters are sane
  
  try
      [dirname,filenamePrefix,darray] = getparams(d,varargin{:});
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
      max_ = max(darray);
      lengths_ = size(darray)
      width_ = lengths_(1);
      height_ = lengths_(2);
      marray_ = zeros(width_, width_);
      size(marray_)
      tic
      %%%for dx = 0:width_ - 1
      for dy = 0:height_ - 1    
          %%%disp(['dx = ' num2str(dx) ' dy = ' num2str(dy)]);
          marray_(dy + 1, :) = double(darray(:, dy, 0));               
      end
      %%%end
      toc
      fullfilename_ = fullfile(dirname, [filenamePrefix '.dcm'])
      dicomwrite(marray_, fullfilename_);
      toc
      returnValue = 0;
      
  catch
      error('sorry...  nil_writemontagedicom failed')
  end
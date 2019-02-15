%NIL_WRITEDICOM integrates into the dipimage GUI & reads dicom data from files
%
% SYNOPSIS:
%  returnValue = nil_writedicom(varargin)
%
% SEE ALSO:
%
% NOTES:
%   
% $Author: jjlee $
% $Date: 2004/06/15 00:08:26 $
% $Revision: 1.1 $
% $Source: /cygdrive/c/local/src/mfiles/RCS/nil_writedicom.m,v $

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

function returnValue = nil_writedicom(varargin)
  
  % setup the dipimage GUI
  
  d = struct('menu','NIL Functions','display','Write a DICOM file','inparams',...
         struct('name',       {'dirname',    'filenamePrefix',   'id',            'darray',           'numSlices',    'lenSlice'},...
			    'description',{'dir. name:', 'filename prefix:', 'ident. info.:', 'dipimage object:', 'num. slices:', 'len. slice:'},...
			    'type',       {'string',     'string',           'string',        'image',            'array',        'array'},...
			    'dim_check',  {0,            0,                  0,               [],                 0,              0},...
			    'range_check',{'*',          '*',                '*',             [],                 'N+',           'N+'},...
			    'required',   {1,            1,                  1,               1,                  1,              1},...
			    'default',    {'T:\',        '',                 '',              'ans',              14,             128}...
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
      [dirname,filenamePrefix,id,darray,numSlices,lenSlice] = getparams(d,varargin{:});
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
      lengths_ = size(darray);
      frameWidth_ = floor(lengths_(1)/lenSlice);
      frameHeight_ = floor(lengths_(2)/lenSlice);
      marray_ = zeros(lenSlice,lenSlice,numSlices);
      dicomarray_ = zeros(lenSlice,lenSlice);
      if (numSlices > frameWidth_*frameHeight_) 
          error('oops...  numSlices is too big for the image-frame');
      end
      tic
      for dy = 0:lengths_(2) - 1
          for dx = 0:lengths_(1) - 1    
              my = mod(dy, lenSlice) + 1;
              mx = mod(dx, lenSlice) + 1;
              framey = floor(dy/lenSlice) + 1;
              framex = floor(dx/lenSlice) + 1;
              slice = (framey - 1)*frameWidth_ + framex;
              %%%if (dx == 0 | dx == lengths_(1) - 1)
              %%%    disp(['dy = ' num2str(dy) ' dx = ' num2str(dx) ' my = ' num2str(my) ' mx = ' num2str(mx) ' framey = ' num2str(framey) ' framex = ' num2str(framex) ' slice = ' num2str(slice)]);
              %%%end
              if (slice <= numSlices)
                  marray_(my, mx, slice) = darray(dx, dy, 0);
              else
                  break;
              end
          end
          if ~(slice <= numSlices) break; end
      end
      toc
      for s = 1:numSlices
          fullfilename_ = fullfile(dirname, [filenamePrefix '_slice' num2str(s) '.dcm'])
          dicomarray_ = marray_(:,:,s);
          dicomwrite(dicomarray_, fullfilename_);
          toc
      end
      returnValue = 0;
      
  catch
      error('sorry...  nil_writedicom failed')
  end
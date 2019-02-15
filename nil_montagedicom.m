%NIL_SINGLEDICOM integrates into the dipimage GUI & reads dicom data from files
%
% SYNOPSIS:
%  metadata = nil_montagedicom(varargin)
%
% SEE ALSO:
%
% NOTES:
%   
% $Author: jjlee $
% $Date: 2004/06/15 00:08:26 $
% $Revision: 1.1 $
% $Source: /cygdrive/c/local/src/mfiles/RCS/nil_montagedicom.m,v $

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

function montage3d = nil_montagedicom(varargin)
  
  % setup the dipimage GUI
  
  d = struct('menu','NIL Functions','display','Read multiple DICOM files into a montage','inparams',...
         struct('name',       {'dirname', 'filenamePrefix',  'seriesNumber', 'instanceNumber', 'numSlices', 'numTimes'},...
			    'description',{'dir. name:', 'filename prefix:', 'series num.:', 'instance num.:', 'num. slices:', 'num. times:'},...
			    'type',       {'string',  'string',          'array',        'array',          'array',     'array'},...
			    'dim_check',  {0,         0,                  0,              0,                0,          0},...
			    'range_check',{'*',       '*',               'N+',           'N+',             'N+',        'N+'},...
			    'required',   {1,         1,                  1,              1,                1,          1},...
			    'default',    {'',        '',                 1,              1,                1,          1}...
         ),...
         'outparams',...
         struct('name',       {'montage3d'},...
				'description',{'montage object name'},...
				'type',       {'image'}...
				)...
      );
  if nargin == 1
     s = varargin{1};
     if ischar(s) & strcmp(s,'DIP_GetParamList')
         montage3d = d;
         return
     end
  end
  
  % check that input parameters are sane
  
  try
      [dirname,filenamePrefix,seriesNumber,instanceNumber,numSlices,numTimes] = getparams(d,varargin{:});
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
      fullfilename_ = ''; % assigned only if files found
      files = dir(dirname); % NumberFiles X 1 struct array with fields:  name, date, bytes, isdir
      
      % search for 1st instance to collect array parameters
      
      Rows_ = 64; % just in case pattern is never matched
      Columns_ = 64;
      pattern_1st = [filenamePrefix '.' num2str(seriesNumber) '.' num2str(instanceNumber)]
      for p = 1:size(files,1)
          if strfind(files(p,1).name, pattern_1st)
              fullfilename_ = fullfile(dirname, files(p,1).name);
              info = dicominfo(fullfilename_);
              Rows_ = info.Rows;
              Columns_ = info.Columns;
              break
          end
      end
      image3d = newim(Rows_, Columns_, numSlices);
      %%%size(image3d) 
      montRows_ = floor(sqrt(numSlices));
      montColumns_ = ceil(numSlices/montRows_);
      montage3d = newim(Columns_*montColumns_, Rows_*montRows_, numTimes);
      %%%size(montage3d)
      
      % searching for multiple slices, multiple times
      
      for pTimes = 1:numTimes
          for pSlices = 1:numSlices
              pattern = [filenamePrefix '.' num2str(seriesNumber) '.' num2str(instanceNumber)];
              
              % search the directory listing for slices
              for p = 1:size(files,1)
                  if strfind(files(p,1).name, pattern)
                      disp(['matched ' files(p,1).name ' at p = ' num2str(p) ' with ' pattern]);
                      fullfilename_ = fullfile(dirname, files(p,1).name);
                      image3d(:,:,pSlices-1) = dip_image(dicomread(fullfilename_), 'uint16');
                      instanceNumber = instanceNumber + 1;
                      break
                  end
                  % test that there really is a break
                  %%%disp(['p = ' num2str(p)]); 
              end
              
              % assign times
              %%%size(arrangeslices(image3d, montColumns_))
              montage3d(:,:,pTimes-1) = arrangeslices(image3d, montColumns_);

          end
          
      end
      
      if ~strcmp(fullfilename_, '')
          disp(['found ' num2str(instanceNumber-1) ' matching DICOM files']);      
      else
          disp('could not find any matching DICOM files');
      end
  catch
      error('sorry...  nil_montagedicom failed')
  end
%NIL_SLICE3D retrieves a 2D slice from a 3D image.
%
%   B = NILSLICE3D(H) returns in B the currently visible slice 
%                       from the 3D image in figure window H.
%
%   Adapted from DIPGETIMAGE.

% ____________________________________________________________________________________
% (C) Copyright 2003                    Neuroimaging Laboratory
%     All rights reserved               Mallinckrodt Institute of Radiology
%                                       Washington University School of Medicine
%                                       4525 Scott Ave, Campus Box 8225
%                                       St. Louis, MO  63110
%                                       USA
%
% John Lee, Sep, 2003

% ____________________________________________________________________________________
% (C) Copyright 1999-2001               Pattern Recognition Group
%     All rights reserved               Faculty of Applied Physics
%                                       Delft University of Technology
%                                       Lorentzweg 1
%                                       2628 CJ Delft
%                                       The Netherlands
%
% Cris Luengo, September 2001
% 22 September 2001: Changed specs of 1D image display (again, *sigh*).

function out = nil_slice3D(fig)

% Parse input
if nargin == 0
   fig = get(0,'CurrentFigure');
   if isempty(fig)
      error('No figure window open to do operation on.')
   end
else % nargin == 1
   if ischar(fig) & strcmp(fig,'DIP_GetParamList')
      out = struct('menu','Display',...
                   'display','Retrieve visible 2D slice from 3D image',...
                   'inparams',struct('name',       {'fig'},...
                                     'description',{'Figure window of 3D image'},...
                                     'type',       {'handle'},...
                                     'dim_check',  {0},...
                                     'range_check',{[]},...
                                     'required',   {0},...
                                     'default',    {[]}...
                                    ),...
                   'outparams',struct('name',{'out'},...
                                      'description',{'Output image'},...
                                      'type',{'image'}...
                                      )...
                  );
      return
   end
%    try
%       fig = getfigh(fig);
%    catch
%       error('Argument must be a valid figure handle.')
%    end
end

tag = get(fig,'Tag');
if ~strncmp(tag,'DIP_Image',9)
   error('nil_slice3D only works on images displayed using DIPSHOW.')
end

udata = get(fig,'UserData');
switch length(udata.imsize)
   case 3
      out = udata.imagedata;
   case {2,1}
      if ~isempty(udata.colspace)
         out = udata.colordata;
      else
         out = udata.imagedata;
      end
   otherwise
      error('Cannot handle dimensionality of image data!')
end


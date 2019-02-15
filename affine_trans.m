% affine_trans translates image contents along orthogonal x, y, z axes.
%
% Usage: [img] = affine_trans(img, trans)
%
%         img:      dip_image, double or FourdData object
%         trans:    row vector with translation [dx dy dz]
%         img:      returned image
%
% Examples: 
%         [img] = affine_trans(img, [1 -2 10])
%
% Created by John Lee on 2008-06-11.
% Copyright (c) 2008 Washington University School of Medicine.  All rights reserved.
% Report bugs to <bug.perfusion.neuroimage.wustl.edu@gmail.com>.

function [img2] = affine_trans(img, trans)

     switch (nargin)
          case 2
               assert(isa(img,'dip_image') || isa(img,'double') || isa(img,'struct'), ...
                      'NIL:affine_trans:ctor:TypeErr:unrecognizedType', ...
                      ['type of img was unexpected: ' class(img)]);
               assert(3 == length(trans), ...
                      'NIL:affine_trans:ctor:InputParameterErr:incompatibleDims', ...
                      ['length of trans was unexpected: ' num2str(length(trans))])
          otherwise
               error('NIL:affine_trans:ctor:PassedParamsErr:numberOfParamsUnsupported', ...
                     help('affine_trans'));
     end
     
     img2  = img;
     sizes = size(img2);
     for z = 0:sizes(3)-1
          for y = 0:sizes(2)-1
               for x = 0:sizes(1)-1
                    [x1 y1 z1] = transform(x,y,z,trans,sizes);
                    img2(x1,y1,z1) = img(x,y,z);
               end
          end
     end
end

function [x1 y1 z1] = transform(x, y, z, trans, sizes) 
     x1 = min(x + trans(1), sizes(1)-1);
     y1 = min(y + trans(2), sizes(2)-1);
     z1 = min(z + trans(3), sizes(3)-1);
     if (x1 < 0) x1 = 0; end
     if (y1 < 0) y1 = 0; end
     if (z1 < 0) z1 = 0; end
end

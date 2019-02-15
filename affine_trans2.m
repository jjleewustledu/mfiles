% affine_trans2 translates image contents along orthogonal x, y, z axes.  
% This 2nd version attempts to speed up array processing.
%
% Usage: [img] = affine_trans2(img, trans)
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
     for q = 1:3
          if (trans(q) > sizes(q))
               trans(q) = mod(trans(q), sizes(q));
          end
     end     

     if (trans(1) > 0)
          img2(trans(1):sizes(1)-1,:,:) = img(0:sizes(1)-1-trans(1),:,:);
     elseif (trans(1) < 0)
          img2(0:sizes(1)-1-abs(trans(1)),:,:) = img(abs(trans(1)):sizes(1)-1,:,:);
     end
     if (trans(2) > 0)
          img2(:,trans(2):sizes(2)-1,:) = img(:,0:sizes(2)-1-trans(2),:);
     elseif (trans(2) < 0)
          img2(:,0:sizes(2)-1-abs(trans(2)),:) = img(:,abs(trans(2)):sizes(2)-1,:);
     end
     if (trans(3) > 0)
          img2(:,:,trans(3):sizes(3)-1) = img(:,:,0:sizes(3)-1-trans(3));
     elseif (trans(3) < 0)
          img2(:,:,0:sizes(3)-1-abs(trans(3))) = img(:,:,abs(trans(3)):sizes(3)-1);
     end
end


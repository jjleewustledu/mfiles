
function [nii h] = reverse_montage(niin, newsize)
%% REVERSE_MONTAGE increases the rank of the passed NIfTI obj.
%  e.g., [256 256 100] -> [64 64 16 100]
%
%  Created by John Lee on 2010-3-16.
%  Copyright (c) 2010 Washington University School of Medicine.  All rights reserved.
%
    
assert(  prod(niin.size) == prod(newsize))

nii = niin;
nii = nii.prepend_fileprefix('nomontage_');
if (length(niin.size) ~= length(newsize))
    switch (length(newsize) - length(niin.size))
        case 1
            assert(length(newsize)   == 4, [  'newsize->' num2str(newsize)]);
            assert(length(niin.size) == 3, ['niin.size->' num2str(niin.size)]);
            oldsize  = niin.size; 
            niin.img = reshape(niin.img, [oldsize(1) oldsize(2) 1 oldsize(3)]);
        otherwise
            error('mfiles:NotImplemented', 'niin.size and newsize are too disparate');
    end
end
img1  = zeros(newsize);
oldsize = niin.size;
assert(newsize(4) == oldsize(4))
for t = 1:newsize(4)
    for z = 1:newsize(3)
        img1(:,:,z,t) = get_subimg(niin, newsize, z, t);
    end
end
nii.img = img1;
h       = nii.dipshow;



    function subimg = get_subimg(niin, newsize, z, t)
        
        %oldsize = niin.size;
        %assert(z <= newsize(3));
        %assert(t <= oldsize(4));
        %assert(length(niin.size) == 4);
        
        factors = niin.size ./ newsize;
        ypos    = (floor((z-1)/factors(1)) + 1) * newsize(2);
        xpos    =   (mod((z-1),factors(1)) + 1) * newsize(1);
        subimg  = niin.img(xpos-newsize(1)+1:xpos, ypos-newsize(2)+1:ypos, 1, t);
        
        assert(size(subimg,1) == newsize(1))
        assert(size(subimg,2) == newsize(2))
    end % get_subimg
end % reverse_montage

%GETSLICEMASK
%
% Usage:  maskSlices = getSliceMask(sliceList, mskSizes)
%
%         maskSlices is a 3D Matlab array of doubles
%         sliceList is a row vector containing slice indices (ints)
%         mskSizes is a row vector containing the dims of the target mask
%
%________________________________________________________________

function sliceMask = getSliceMask(sliceList, mskSizes)

if size(sliceList, 1) > 1, 
    error('peekCoords.getSliceMask requires that sliceList be a row vector'); 
end
if size(mskSizes, 2) < 3,
    error('peekCoords.getSliceMask requires mskSizes to be at least 3D');
end

NSLICES   = size(sliceList, 2);
sliceMask = zeros(mskSizes(1,1), mskSizes(1,2), mskSizes(1,3));
oneSlice  = ones (mskSizes(1,1), mskSizes(1,2));
for s = 1:mskSizes(1,3)
    for s1 = 1:NSLICES
        if (s == sliceList(1,s1)) 
            sliceMask(:,:,s) = oneSlice; 
        end
    end
end
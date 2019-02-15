% Usage:  brain = brainTimecurve(img, thresh)
%         img    -> 4dfp DSC EPI data in voxels (X) time-shots
%         thresh -> min. threshold for mask of brain parenchyma

function brain = brainTimecurve(img, thresh)

sz = size(img);
dim1 = sz(1);
dim2 = sz(2);
dim3 = sz(3);
dim4 = sz(4);

mask = newim(dim1, dim2, dim3, 1);
mask = img(:,:,:,0) > thresh

numvoxels = sum(mask)

brain = zeros(1,1,1,dim4);
dimg = double(img);
for k = 1:dim3
    for j = 1:dim1
        for i = 1:dim2
            brain(1,1,1,:) = brain(1,1,1,:) + dimg(i,j,k,:);
        end
    end
end

brain = squeeze(brain);
brain = brain/numvoxels;
brain = dip_image(brain)
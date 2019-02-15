function h = make_nii_montage(nii)

sz = nii.size;

imgs  = zeros(sz(2), sz(1), 1, sz(3));
for s = 1:sz(3) 
    imgs( :,:,:,s) = flip4d(nii.img(:,:,s), 'ty');
end

h = montage(imgs, 'DisplayRange', [0 1]);

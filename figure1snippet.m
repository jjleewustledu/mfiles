qcbf = NIfTI.load('qcbf_warped.nii.gz')
qcbv = NIfTI.load('qcbv_warped.nii.gz')
ho = NIfTI.load('ho_warped.nii.gz')
oo = NIfTI.load('oo_warped.nii.gz')
oc = NIfTI.load('oc_warped.nii.gz')
db = mlfsl.Np797Registry.instance('p7395')
mask = NIfTI.load('MNI152_T1_2mm_brain_mask.nii.gz')
mask_dil = NIfTI.load('MNI152_T1_2mm_brain_mask_dil.nii.gz')
petbldr = mlpet.PETBuilder.createFromModalityPath();
petbldr.honii = ho;
petbldr.oonii = oo;
petbldr.ocnii = oc;
petbldr.blur  = [0 0 0];
%-- 3/11/10  3:31 PM --%
petbldr
petbldr.make_cbfnii
petbldr.cbfnii.showimg
petbldr.make_cbvnii
petbldr.make_mttnii
db = mlfsl.Np797Registry.instance('p7395')
petbldr.make_mttnii
petbldr.blur
db.mrBlur
petbldr.cbfnii
petbldr.cbfnii.pixdim
db.mrBlur / 2
db = mlfsl.Np797Registry.instance('p7395')
qcbf
[7.3111 7.3111 5.33] ./ 2
%-- 3/11/10  3:53 PM --%
db = mlfsl.Np797Registry.instance('p7395')
petbldr = mlpet.PETBuilder.createFromModalityPath();
db = mlfsl.Np797Registry.instance('p7395')
petbldr = mlpet.PETBuilder.createFromModalityPath();
petbldr.make_cbfnii
petbldr.honii = ho;
petbldr.oonii = oo;
petbldr.ocnii = oc;
petbldr.make_cbfnii
petbldr.make_cbvnii
petbldr.make_mttnii
petbldr = mlpet.PETBuilder.createFromModalityPath();
petbldr.honii = ho;
petbldr.oonii = oo;
petbldr.ocnii = oc;
petbldr.foreground.showimg
petbldr.make_cbfnii
petbldr.cbfnii.showimg
petbldr.make_cbvnii
petbldr.make_mttnii
petbldr.mttnii.showimg
petbldr.make_oefnii
petbldr.cbfnii.showimg
petbldr.cbfnii = petbldr.cbfnii .* mask
petbldr.cbfnii.showimg
help imshow
imshow(petbldr.cbfnii.mlimage)
imshow(double(reorder(petbldr.cbfnii.img), [91 109 1 91]))
imshow(reorder(double(petbldr.cbfnii.img), [91 109 1 91]))
help reorder
imtool
tmpimg = double(petbldr.cbfnii.img);
tmpimg = tmpimg(:,:,43);
tmpimg = tmpimg';
imtool
tmpimg = double(petbldr.cbfnii.img(:,:,42));
tmpimg = flip4d(dip_image(petbldr.cbfnii.img(:,:,43)), 'yt');
tmpimg = flip4d(petbldr.cbfnii.img(:,:,43), 'yt');
imtool
tmpimg = petbldr.cbfnii.img(:,:,43);
imtool
tmpimg = flip4d(petbldr.cbfnii.img(:,:,43), 'yt');
imtool
tmpimg = flip4d(petbldr.cbfnii.img(:,:,43), 'xt');
imtool
%-- 3/11/10  6:21 PM --%
mlpet.PETBuilder.createFromModalityPath();
petbldr.honii = ho;
petbldr.oonii = oo;
petbldr.ocnii = oc;
petbldr.make_cbfnii
petbldr.make_cbvnii
petbldr.make_mttnii
db = mlfsl.Np797Registry.instance('p7395')
petbldr = mlpet.PETBuilder.createFromModalityPath();
petbldr.honii = ho;
petbldr.oonii = oo;
petbldr.ocnii = oc;
petbldr.make_cbfnii
petbldr.make_cbvnii
petbldr.make_mttnii
petbldr.cbfnii = petbldr.cbfnii .* mask
petbldr.cbvnii = petbldr.cbvnii .* mask
petbldr.mttnii = petbldr.mttnii .* mask
tmpimg = flip4d(petbldr.cbfnii.img(:,:,43), 'xt');
imtool
open('startup.m')
help path
path(path,'/Users/jjlee/MATLAB-Drive/export_fig')
set(gcf, 'inverthardcopy', 'off')
open('startup.m')
export_fig
ghostscript
which gs-X11
path
gcf
help gcf
print(gcf, '-depsc2', '-cmyk', '-r500', 'petColorBar.eps')
print(gcf, '-depsc2', '-cmyk', '-r500', 'petColorBar2.eps')
print(gcf, '-dtiff', '-cmyk', '-r500', 'petColorBar2.eps')
print(gcf, '-depsc2', '-cmyk', '-r500', 'petColorBar2.eps')
print(gcf, '-dtiff', '-cmyk', '-r500', 'petColorBar2.tif')
help export_fig
%-- 3/12/10  4:27 AM --%
%-- 3/12/10  4:28 AM --%
qcbf.showimg
qcbf
qcbf = NIfTI.load('qcbf_warped.nii.gz')
qcbv = NIfTI.load('qcbv_warped.nii.gz')
qcbf.showimg
tmpimg = flip4d(qcbfnii.img(:,:,43), 'xt');
tmpimg = flip4d(qcbf.img(:,:,43), 'xt');
imtool
qcbf = qcbf .* mask
mask = NIfTI.load('MNI152_T1_2mm_brain_mask.nii.gz')
mask = NIfTI.load('/opt/fsl/data/standard/MNI152_T1_2mm_brain_mask.nii.gz')
mask = NIfTI.load('MNI152_T1_2mm_brain_mask.nii.gz')
mask_dil = NIfTI.load('MNI152_T1_2mm_brain_mask_dil.nii.gz')
qcbf = qcbf .* mask
qcbf.showimg
tmpimg = flip4d(qcbf.img(:,:,43), 'xt');
imtool
db = mlfsl.Np797Registry.instance('p7395')
qcbfbb = NiiBrowser(qcbf, mask, db.mrBlur, [1 1 1])
tmpimg = flip4d(qcbfbb.img(:,:,43), 'xt');
imtool
qcbf = NIfTI.load('qcbf_warped.nii.gz')
qcbfbb = NiiBrowser(qcbf, mask, db.mrBlur, [1 1 1])
tmpimg = flip4d(qcbfbb.img(:,:,43), 'xt');
imtool
tmpimg = flip4d(petbldr.cbfnii.img(:,:,43), 'xt');
petbldr
tmpimg = flip4d(petbldr.cbfnii.img(:,:,43), 'xt');
imtool
qcbv
qcbvbb = NiiBrowser(qcbv, mask, db.mrBlur, [1 1 1])
tmpimg = flip4d(qcbvbb.img(:,:,43), 'xt');
imtool
tmpimg2 = flip4d(petbldr.cbvnii.img(:,:,43), 'xt');
imtool
help imtool

%-- Unknown date --%
db
db.fg_filename
db.grey_filename
db.ho_filename
db.fg_filename
db.mr0_filename
db.mr0_filename('cbf')
db.mr1_filename('cbf')
db.t1_filename
db.pet_filename
db.pet_filename('cbf')
db = mlfsl.Np797Registry.instance('p7248')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db
db = mlfsl.Np797Registry.instance('p7248')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db.oc_filename
%-- 6/18/09  3:20 AM --%
mlfourd.NiiBrowser.fwhh2sigma(16)
help fwhh2sigma
mlfourd.NiiBrowser.fwhh2sigma(16,[1 1 1])
%-- 6/18/09  8:57 AM --%
db = mlfsl.Np797Registry.instance('p7243')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
%-- 6/18/09  9:24 AM --%
petoef = read_nii('petoef_on_oef.nii.gz')
help read_nii
help save_nii
petoef = mlfourd.NIfTI.load('petoef_on_oef.nii.gz')
petoef.img = double(dip_image(petoef.img) > 0);
petoef.untouch = 0;
petoef.hdr
petoef.hdr.hk
petoef.hdr.dime
petoef.hdr
petoef.hdr.hist
petoef
petoef.fileprefix = 'petmsk'
save_nii(petoef, 'petmsk.nii.gz')
%-- 6/18/09 11:28 AM --%
db = mlfsl.Np797Registry.instance('p7257')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db = mlfsl.Np797Registry.instance('p7260')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db = mlfsl.Np797Registry.instance('p7266')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db = mlfsl.Np797Registry.instance('p7267')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db = mlfsl.Np797Registry.instance('p7270')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
%-- 6/18/09 12:37 PM --%
db = mlfsl.Np797Registry.instance('p7248')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
%-- 6/18/09 12:41 PM --%
db = mlfsl.Np797Registry.instance('p7248')
db.petPath
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
%-- 6/18/09  2:36 PM --%
%-- 6/18/09  2:44 PM --%
oef = mlfourd.NIfTI.load('oefm.nii.gz')
oef.hdr
oef.hdr.hk
oef.hdr.dime
oef.hdr.dime.dim = [3 48 64 1 1 1 1 1];
oef.hdr.dime.pixdim = [1 4 4 1 1 1 1 1];
oef.hdr
oef.hdr.hist
oef.hdr.hist.descrip = 'colorbar [0...1]';
ls
oef
bar = zeros(48,64);
for x = 1:48
for y = 1:64
incr = 0;
for y = 1:64
incr = incr + (y-1)/64;
bar(:,y) = incr;
end
dip_image(bar)
incr = 0;
for y = 1:64
incr = incr + (y-1)/64;
disp(num2str(incr));
for y = 1:64
bar(:,y) = (y-1)/64;
end
dip_image(bar)
oef.img = bar
save_nii(oef, 'colorbar.nii.gz')
gzip petoef_on_oef.nii
petoef = mlfourd.NIfTI.load('petoef_on_oef.nii.gz')
montage(petoef.img)
petoefc = cell(24);
for c = 1:24
petoefc{c} = petoef.img(:,:,c);
end
montage(petoefc)
for c = 1:24
petoefc{c} = squeeze(petoef.img(:,:,c));
end
montage(petoefc)
petoefa = analyze75read('petoef_on_oef')
size(petoefa)
class(petoefa)
info = analyze75read('petoef_on_oef.hdr')
info = analyze75read('petoef_on_oef.hdr');
size(info)
info = analyze75info('petoef_on_oef.hdr');
info
petoefa = analyze75read(info);
size(petoefa)
dip_image(petoefa)
Y = reshape(petoefa, [64 48 1 24]);
montage(Y)
class(petoefa)
petoef = mlfourd.NIfTI.load('petoef_on_oef.nii.gz');
size(petoef.img)
montage(reshape(petoef.img, [46 64 1 24]))
montage(reshape(petoef.img, [48 64 1 24]))
montage(repmap(petoef.img, [1 1 1 24]))
montage(repmap(double(petoef.img), [1 1 1 24]))
montage(repmat(petoef.img, [1 1 1 24]))
montage(reshape(petoef.img, [48 64 1 24]))
open('flip4d')
montage(reshape(flip4d(petoef.img, 'x'), [48 64 1 24]))
montage(reshape(petoef.img, [48 64 1 24]))
montage(reshape(flip4d(petoef.img, 'y'), [48 64 1 24]))
montage(reshape(flip4d(petoef.img, 't'), [48 64 1 24]))
montage(reshape(flip4d(petoef.img, 't'), [64 48 1 24]))
length('xy')
xy = 'xy';
length(xy(2:length(xy)))
montage(reshape(flip4d(petoef.img, 'ty'), [64 48 1 24]))
montage(reshape(flip4d(petoef.img, 'yt'), [64 48 1 24]))
montage(reshape(petoef.img, [48 64 1 24]))
montage(reshape(flip4d(petoef.img, 't'), [64 48 1 24]))
montage(reshape(flip4d(petoef.img, 'tt'), [48 64 1 24]))
montage(reshape(flip4d(petoef.img, 'tt'), [64 48 1 24]))
montage(reshape(flip4d(petoef.img, 'ttt'), [64 48 1 24]))
montage(reshape(flip4d(petoef.img, 'tt'), [48 64 1 24]))
montage(reshape(flip4d(petoef.img, 'ttt'), [64 48 1 24]))
montage(reshape(flip4d(petoef.img, 'tttt'), [48 64 1 24]))
montage(reshape(flip4d(petoef.img, 'xy'), [48 64 1 24]))
montage(reshape(flip4d(petoef.img, 'yt'), [64 48 1 24]))
montage(reshape(flip4d(petoef.img, 't'), [64 48 1 24]))
montage(reshape(flip4d(petoef.img, 'xt'), [64 48 1 24]))
zoom(2)
montage(reshape(flip4d(petoef.img, 'xt'), [64 48 1 24]))
oefm = mlfourd.NIfTI.load('oefm.nii.gz')
oefmgm = mlfourd.NIfTI.load('oefm_g16petmsk.nii.gz')
montage(reshape(flip4d(petoef.img, 'xt'), [64 48 1 24]))
petfig = montage(reshape(flip4d(petoef.img, 'xt'), [64 48 1 24]))
oefmfig = montage(reshape(flip4d(oefm.img, 'xt'), [64 48 1 24]))
help figure
oefmfig = figure
montage(reshape(flip4d(petoef.img, 'xt'), [64 48 1 24]))
figure
figure('Name', 'MR OEF')
montage(reshape(flip4d(oefm.img, 'xt'), [64 48 1 24]))
figure('Name', 'MR OEF 16 mm blur')
montage(reshape(flip4d(oefmgm.img, 'xt'), [64 48 1 24]))
montage(reshape(flip4d(oefm.img, 'yxt'), [64 48 1 24]))
figure('Title', 'PET OEF 16 mm blur')
figure
title('PET OEF 16 mm blur')
montage(reshape(flip4d(petoef.img, 'xt'), [64 48 1 24]))
colormap jet
colorbar
colormap(contrast(gca))
colormap('jet')
title('PET OEF 16 mm blur')
set('CLim', [0 0.6])
set(gcf,'CLim', [0 0.6])
set(gca,'CLim', [0 0.6])
figure
title('MR OEF')
montage(reshape(flip4d(oefm.img, 'yxt'), [64 48 1 24]))
colormap jet
colorbar
set(gcf, 'CLim', [0 0.6])
title('MR OEF')
set(gcf, 'CLim', [0 0.6])
set(gca, 'CLim', [0 0.6])
figure
montage(reshape(flip4d(oefmgm.img, 'yxt'), [64 48 1 24]))
colormap jet
colorbar
set(gca, 'CLim', [0 0.6])
title('MR OEF 16 mm blur')
set(gca, 'FontSize', 18)
set(gca, 'FontSize', 14)
db.petPath
db = mlfsl.Np797Registry.instance('p7243')
db.petPath
db = mlfsl.Np797Registry.instance('p7248')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db = mlfsl.Np797Registry.instance('p7257')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db = mlfsl.Np797Registry.instance('p7260')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db = mlfsl.Np797Registry.instance('p7266')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db = mlfsl.Np797Registry.instance('p7267')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))
db = mlfsl.Np797Registry.instance('p7270')
run(runner, load_tests_from_test_case(loader, 'mlpet_xunit.Test_PETBuilder'))

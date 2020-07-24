function dat = createMaskForEpilepsyTraining(location)

% assert prerequisites
r = which('mlfourd.ImagingFormatContext');
assert(isfile(strtrim(r)), 'missing access to John Lee''s Matlab repositories')
[~,r] = system('which flirt');
assert(isfile(strtrim(r)), 'missing FSL utilities')
assert(isfolder(location), '%s not found on filesystem', location)

% read and write files in location
pwd0 = pwd;
cd(location) % pushd

% create mask for epilepsy
wm = mlfourd.ImagingFormatContext('wmparc_on_MNI152_T1_1mm.nii.gz');
indicesHippocampus = [17 53 1016 2016 3016 4016];
indicesAmygdala = [18 54];
indicesTemporal = [1009 1015 1033 2009 2015 2033 3009 3015 3033 4009 4015 4033];
img = zeros(size(wm));
for idx = [indicesHippocampus indicesAmygdala indicesTemporal]
    img = img + (wm.img == idx);
    fprintf('# trues -> %g\n', dipsum(img))
end
epilepsy = copy(wm);
epilepsy.img = img;
epilepsy.filename = 'mask_epilepsy_1mm.nii.gz';
epilepsy.save();

% register mask to gm3d
filename1 = 'mask_epilepsy_3mm.nii.gz';
system(sprintf('flirt -in %s -applyxfm -init MNI152_T1_1mm_on_711-2B_333.mat -out %s -paddingsize 0.0 -interp nearestneighbour -ref 711-2B_333.nii.gz', ...
    epilepsy.filename, filename1))

% create mat file consistent with Patrick's conventions
epilepsy333 = mlfourd.ImagingFormatContext(filename1);
dat = reshape(flip(epilepsy333.img, 2), [48*64*48 1]);
save('epilepsy_333.mat', 'dat')

cd(pwd0) % popd

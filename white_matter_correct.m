function glom = white_matter_correct(pid, slice, glom, flipw);

%% WHITE_MATTER_CORRECT
%  Usage:   glom = white_matter_correct(pid, slice, glom, flipw);
%
BINS = 128;
ASSUMED_CBF = 22; % mL/min/100 g
if (4 == nargin)
    flipWhite = flipw;
else
    flipWhite = 0;
end

% check SVD CBF
db = mlfsl.Np797Registry.instance(pid);
glom.slice.(pid) = slice;
glom.flipwhite.(pid) = flipWhite;
if (exist(db.mr0_filename('cbf'), 'file'))
    glom.scbfs.(pid) = mlfourd.NIfTI.load(db.mr0_filename('cbf'));
else
    glom.scbfs.(pid) = jessycells2nii(db);
end
size_scbf = size(glom.scbfs.(pid).img);
disp(['scbfs.' pid '.img has size -> ' num2str(size_scbf)])
%%disp(['showing dip_image of scbfs.' pid '.img and pixel histogram..........'])
%%f1 = dip_image(glom.scbfs.(pid).img);
%%dipshow(f1, 'percentile')
%%figure; hist(reshape(glom.scbfs.(pid).img, [prod(size_scbf) 1]), BINS)


% check white-matter mask
disp(['loading glom.whites.' pid '..........'])
white_fname = [db.fsl_path 'white_xr3d.nii.gz'];
if (~exist(white_fname, 'file'))
    error('mlfourd:FileNotFound', white_fname);
end
if (flipWhite)
    wm     = mlfourd.NIfTI.load(white_fname);
    wm.img = flip4d(wm.img, 'y');
    glom.whites.(pid) = wm;
else
    glom.whites.(pid) = mlfourd.NIfTI.load(white_fname);
end
size_white = size(glom.whites.(pid).img);
disp(['whites.' pid ' has size -> ' num2str(size_white)])
%%disp(['showing dip_image of whites.' pid ' and pixel histogram..........'])
%%f2 = dip_image(glom.whites.(pid).img);
%%dipshow(f2, 'percentile')
%%figure; hist(reshape(glom.whites.(pid).img, [prod(size_white) 1]), BINS)


% do masking and find scaling factor < 1
maskedimg = double(glom.scbfs.(pid).img) .* double(glom.whites.(pid).img);
maskedslice = maskedimg(:,:,slice);
assert(2 == size(size(maskedslice), 2));
assert(3 == size(size(glom.whites.(pid).img), 2));
white_raw = sum(sum(maskedslice)) / sum(sum(glom.whites.(pid).img(:,:,slice)));
glom.scalingfactors.(pid) = ASSUMED_CBF / white_raw;


% make white-matter scaled CBF-map
glom.cbfmaps.(pid) = glom.scalingfactors.(pid) * glom.scbfs.(pid).img;
size_cbfm = size(glom.cbfmaps.(pid));
disp(['cbfmaps.' pid ' has size -> ' num2str(size_cbfm)])
%%disp(['showing dip_image of cbfmaps.' pid ' and pixel histogram..........'])
%%f3 = dip_image(glom.cbfmaps.(pid));
%%dipshow(f3, 'percentile')
figure; hist(reshape(glom.cbfmaps.(pid), [prod(size_cbfm) 1]), BINS)

fcbf   = dip_image(glom.cbfmaps.(pid));
fcbf   = squeeze(fcbf(:,:,slice-1));
fwhite = dip_image(glom.whites.(pid).img);
fwhite = squeeze(fwhite(:,:,slice-1));
f4     = fcbf/(max(fcbf) - 3*std(fcbf)) + fwhite;
dipshow(f4, 'lin')
glom.scalingfactors

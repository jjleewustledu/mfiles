function [fqfn,inference_on_stealth] = register_patricks_img_to_RT_subject_fsl(varargin)
%% REGISTER_PATRICKS_IMG_TO_RT_SUBJECT_FSL registers numeric _img_ to tumor imaging of _subject_id_ from the RT cohort.
%  Usage:
%      >> % write results in ./RT016, then launches fsleyes:
%      >> register_patricks_img_to_RT_subject_fsl(img16, 'subject_id', 'RT016') 
%      >> % write results in /path/to/results, then returns the fully-qualified filename of registration result:
%      >> fqfn = register_patricks_img_to_RT_subject_fsl( ...
%      >>        'RT017_LAN.nii.gz', 'subject_id', 'RT017', 'subjects_dir', '/path/to/results', 'do_view', false)
%  Args:
%      inference (any): providing 48x64x48 img on 333 atlas with "left-anterior-superior" NIfTI orientation.
%      subjects_dir (folder): destination for registration results.
%      subject_id (text): must exist in data_repository.
%      do_view (logical): view results in fsleyes; _default_ is true.
%      do_clean (logical): delete intermediates; _default_ is false.
%      data_repository (folder): _default_ is /data/nil-bluearc/shimony/ADaniel/Tumor2/rsfMRITumor, which is _not writable_.
%      
%  Returns:
%      fqfm: fully-qualified filename of img registered to tumor imaging.
%      relevant imaging in fullfile(subjects_dir, subject_id)
%      fsleyes invocation displaying img registered to STEALTH.
%
%  Created 17-May-2022 15:49:20 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.10.0.1851785 (R2021a) Update 6 for MACI64.  Copyright 2022 John J. Lee.

%% add path

assert(isfolder('/data/nil-bluearc'), 'network folder /data/nil-bluearc not found')
addpath('/data/nil-bluearc/raichle/jjlee/Documents/MATLAB')
try
    registry = PublicMatlabRegistry.instance('initialize'); %#ok<NASGU>
catch ME
    disp(ME)
end

%% parse parameters

ip = inputParser;
addRequired(ip, 'inference', @(x) ~isempty(x))
addParameter(ip, 'subjects_dir', pwd, @isfolder)
addParameter(ip, 'subject_id', '', @istext)
addParameter(ip, 'do_view', true, @islogical)
addParameter(ip, 'do_clean', true, @islogical)
addParameter(ip, 'data_repository', '/data/nil-bluearc/shimony/ADaniel/Tumor2/rsfMRITumor', @isfolder)
addParameter(ip, 'anat_ave_searchrx', 45, @isscalar)
addParameter(ip, 'mr_dir_index', 1, @isscalar)
parse(ip, varargin{:})
ipr = ip.Results;
ipr.inference = mlfourd.ImagingContext2(ipr.inference);

%% prepare filesystems, environment

src_dir = fullfile(ipr.data_repository, ipr.subject_id, '');
dest_dir = fullfile(ipr.subjects_dir, ipr.subject_id, '');
assert(isfolder(src_dir), '%s not found', src_dir)
ensuredir(dest_dir);

if isempty(getenv('RELEASE'))
    setenv('RELEASE', '/data/nil-bluearc/raichle/jjlee/.local/lin64-tools');
end

%% prepare NIfTI

g = globFolders(fullfile(src_dir, sprintf('%s_MR*', ipr.subject_id)));
mr_dir = g{ipr.mr_dir_index};
pwd0 = pushd(mr_dir);

sst = mlfourdfp.SCANS_studies_txt();
post_tag = sst.dcm2niix_postGd('o', dest_dir);
mpr_tag = sst.dcm2niix_mpr('o', dest_dir);
flair_tag = sst.dcm2niix_flair('o', dest_dir);

g1 = glob(fullfile(dest_dir, ['sub*ses*' post_tag '*.nii.gz']));
g2 = glob(fullfile(dest_dir, ['sub*ses*' mpr_tag '*.nii.gz']));
g3 = glob(fullfile(dest_dir, ['sub*ses*' flair_tag '*.nii.gz']));
g4 = glob(fullfile(mr_dir, 'atlas', '*anat_ave_*_333.4dfp.hdr'));

stealth = mlfourd.ImagingContext2(g1{1});
stealth.selectNiftiTool();
mpr = mlfourd.ImagingContext2(g2{1});
flair = mlfourd.ImagingContext2(g3{1});
anat_ave = mlfourd.ImagingContext2(g4{1});
anat_ave.selectNiftiTool();
anat_ave.filepath = dest_dir;
anat_ave.save();

re = regexp(mybasename(g1{end}), '(?<sub>sub-\w+)_(?<ses>ses-\d{14})(?<suffix>\S+)', 'names');
assert(~isempty(re));
inference = copy(anat_ave.imagingFormat);
inference.img = ipr.inference.imagingFormat.img;
inference.fqfp = fullfile(dest_dir, sprintf('%s_%s_%s', re.sub, re.ses, ipr.inference.fileprefix));
inference.save();

popd(pwd0);

%% do flirt

pwd1 = pushd(dest_dir);

flair_mskt = mlfourd.ImagingContext2( ...
    mlfsl.Flirt.msktgen(flair.fqfn, 'dof', 6));
flair_brain = flair_mskt .* flair;
if ~isfile(strcat(anat_ave.fqfp, '_on_stealth.mat'))
    f3 = mlfsl.Flirt( ...
        'in', anat_ave, ...
        'ref', flair_brain, ...
        'out', strcat(anat_ave.fqfp, '_on_flair.nii.gz'), ...
        'omat', strcat(anat_ave.fqfp, '_on_flair.mat'), ...
        'bins', 256, ...
        'cost', 'mutualinfo', ...
        'dof', 6, ...
        'searchrx', ipr.anat_ave_searchrx, ...
        'searchry', 15, ...
        'searchrz', 15, ...
        'interp', 'trilinear');
    f3.flirt();
    f2 = mlfsl.Flirt( ...
        'in', flair, ...
        'ref', mpr, ...
        'out', strcat(flair.fqfp, '_on_mpr.nii.gz'), ...
        'omat', strcat(flair.fqfp, '_on_mpr.mat'), ...
        'bins', 256, ...
        'cost', 'corratio', ...
        'dof', 6, ...
        'searchrx', 90, ...
        'interp', 'trilinear');
    f2.flirt();
    f1 = mlfsl.Flirt( ...
        'in', mpr, ...
        'ref', stealth, ...
        'out', strcat(mpr.fqfp, '_on_stealth.nii.gz'), ...
        'omat', strcat(mpr.fqfp, '_on_stealth.mat'), ...
        'bins', 256, ...
        'cost', 'corratio', ...
        'dof', 6, ...
        'searchrx', 90, ...
        'interp', 'trilinear');
    f1.flirt();
    f = mlfsl.Flirt();
    f.concatXfm('AtoB', f3.omat, 'BtoC', f2.omat, 'AtoC', strcat(anat_ave.fqfp, '_on_mpr.mat'));
    f = mlfsl.Flirt();
    f.concatXfm('AtoB', strcat(anat_ave.fqfp, '_on_mpr.mat'), 'BtoC', f1.omat, 'AtoC', strcat(anat_ave.fqfp, '_on_stealth.mat'));
    f.in = inference;
    f.out = strcat(inference.fqfp, '_on_stealth.nii.gz');
    f.ref = stealth;
    f.applyXfm();
    inference_on_stealth = f.out;
    inference_on_stealth.selectNiftiTool();
    fqfn = inference_on_stealth.fqfn;
else
    f = mlfsl.Flirt();
    f.in = inference;
    f.out = strcat(inference.fqfp, '_on_stealth.nii.gz');
    f.ref = stealth;
    f.omat = strcat(anat_ave.fqfp, '_on_stealth.mat');
    f.applyXfm();
    inference_on_stealth = f.out;
    inference_on_stealth.selectNiftiTool();
    fqfn = inference_on_stealth.fqfn;
end

popd(pwd1);

%% do view

if ipr.do_view
    stealth.view_qc(inference_on_stealth);
end

%% clean up intermediates

if ipr.do_clean
    %deleteExisting(strcat(mpr.fqfp, '*_on_*.nii.gz'));
    %deleteExisting(strcat(flair.fqfp, '*_on_*.nii.gz'));
    %deleteExisting(strcat(anat_ave.fqfp, '_on_*.nii.gz'));
    deleteExisting(fullfile(dest_dir, '*_reslice.*'));
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/register_patricks_img_to_RT_subject_fsl.m] ======  

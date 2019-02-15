function nii = repackage_nii(nii0, ref)

%% REPACKAGE a NIfTI nii0 inside a reference NIfTI
%  Usage:  nii = repackage_nii(nii0, ref)
assert(strcmp(class(nii0), class(ref)));
nii = ref;
nii.fileprefix = nii0.fileprefix;
nii.img        = nii0.img;
nii.label      = nii0.label;
nii.descrip    = nii0.descrip;
assert(all(ref.pixdim - nii0.pixdim) < .01);
assert(all(ref.size   - nii0.size    < .01));
switch (class(nii0))
    case 'mlfourd.INIfTI'
    case 'mlfourd.NiiBrowser'
        assert(all(ref.blur  - nii0.blur  < .01));
        assert(all(ref.block - nii0.block < .01));
    otherwise
        error('mfiles:NotImplementedErr', 'repackage_nii');
end


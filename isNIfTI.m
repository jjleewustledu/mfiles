%% ISNIFTI
%  Usage:  truthval = isNIfTI(nii)
%                             ^ expected to be NIfTI

function truthval = isNIfTI(nii)

    truthval = mlfourd.NIfTI.isNIfTI(nii);
end

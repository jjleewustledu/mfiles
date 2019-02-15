function obj = ensureMask(obj)

%% ENSURENII returns NIfTI for any plausible string, numerical type, NIfTI subclass
%  Usage:  obj = ensureNii(obj)
import mlfourd.*;
switch (class(obj))
    case 'char'
        try
            obj = NIfTI_mask.load(obj);
        catch ME
            handexcept(ME, ['ICHemorrhage.make_contralateral.obj could not be found on disk:  ' obj]);
        end
    case numeric_types
        obj = NIfTI_mask(obj);
    case NIfTI.NIFTI_SUBCLASS
    otherwise
        error('mfiles:InputParamTypeUnknown', ['class(ensureNii.obj)->' class(obj)]);
end
obj = NIfTI_mask.ensureMask(obj);

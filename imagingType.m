function im = imagingType(typ, obj)
%% IMAGINGTYPE returns imaging data cast as a requested representative type detailed below.
%  @deprecated
%  @param typ is the requested representation:  'filename', 'fn', fqfilename', 'fqfn', 'fileprefix', 'fp',
%  'fqfileprefix', 'fqfp', 'folder', 'path', 'ext', 'ImagingContext2', 
%  '4dfp.hdr', '4dfp.ifh', '4dfp.img', '4dfp.img.rec', 'v', 'v.hdr', 'v.mhdr'. 
%  @param obj is the representation of imaging data provided by the client.  
%  @returns im is the imaging data obj cast as the requested representation.

import mlfourd.*;
if ischar(obj) && isfolder(obj)
    im = ImagingContext2.locationType(typ, obj);
    return
end

obj = ImagingContext2(obj);
switch typ
    case {'4dfp.hdr' '.4dfp.hdr'}
        im = [obj.fqfileprefix '.4dfp.hdr'];
    case {'4dfp.ifh' '.4dfp.ifh'}
        im = [obj.fqfileprefix '.4dfp.ifh'];
    case {'4dfp.img' '.4dfp.img'}
        im = [obj.fqfileprefix '.4dfp.img'];
    case {'4dfp.img.rec' '.4dfp.img.rec'}
        im = [obj.fqfileprefix '.4dfp.img.rec'];
    case  'ext'
        [~,~,im] = myfileparts(obj.filename);
    case  'folder'
        [~,im] = fileparts(obj.filepath);
    case {'filepath' 'path'}
        im = obj.filepath;
    case {'fileprefix' 'fp'}
        im = obj.fileprefix;
    case {'filename' 'fn'}
        im = obj.filename;
    case {'fourdfp' 'Fourdfp' 'mlfourdfp.Fourdfp'}
        im = obj.fourdfp;
    case {'fqfilename' 'fqfn'}
        im = obj.fqfilename;
    case {'fqfileprefix' 'fqfp' 'fdfp' '4dfp'}
        im = obj.fqfileprefix;                  
    case {'ImagingContext2' 'mlfourd.ImagingContext2'}
        im = obj;
    case {'ImagingFormatContext2' 'mlfourd.ImagingFormatContext2'}
        im = obj.imagingFormat;
    case {'mgz' '.mgz'}
        im = [obj.fqfileprefix '.mgz'];
    case {'mhdr' '.mhdr'}
        im = [obj.fqfileprefix '.mhdr'];                  
    case {'nii' '.nii'}
        im = [obj.fqfileprefix '.nii'];
    case {'nii.gz' '.nii.gz'}
        im = [obj.fqfileprefix '.nii.gz'];
    case {'mgh' 'MGH' 'mlsurfer.MGH'}
        im = obj.mgh;
    case {'nifti' 'NIfTI'}
        im = obj.nifti;
    case {'niftid' 'NIfTId' 'mlfourd.NIfTId'}
        im = obj.niftid;
    case {'numericalNiftid' 'NumericalNIfTId' 'mlfourd.NumericalNIfTId'}
        im = obj.numericalNiftid;
    case {'v' '.v'}
        im = [obj.fqfileprefix '.v'];
    case {'v.hdr' '.v.hdr'}
        im = [obj.fqfileprefix '.v.hdr'];
    case {'v.mhdr' '.v.mhdr'}
        im = [obj.fqfileprefix '.v.mhdr'];
    case 'double'
        if contains(obj.filesuffix, '4dfp')
            im = double(obj.fourdfp.img);
        elseif contains(obj.filesuffix, 'mgh')
            im = double(obj.mgh.img);
        elseif contains(obj.filesuffix, 'mgz')
            im = double(obj.mgz.img);
        else
            im = double(obj.nifti.img);
        end
    case 'single'
        if contains(obj.filesuffix, '4dfp')
            im = single(obj.fourdfp.img);
        elseif contains(obj.filesuffix, 'mgh')
            im = single(obj.mgh.img);
        elseif contains(obj.filesuffix, 'mgz')
            im = single(obj.mgz.img);
        else
            im = single(obj.nifti.img);
        end
    otherwise
        error('mlfourd:insufficientSwitchCases', ...
              'ImagingContext2.imagingType.obj->%s not recognized', obj);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/imagingType.m] ======  

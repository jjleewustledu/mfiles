function fn_nii = fourdfp2nifti(fn_4dfp, opts)
%% FOURDFP2NIFTI converts 4dfp imaging to NIfTI and JSON sidecar.
%  Args:
%      fn_4dfp {mustBeFile}
%      opts.noclobber logical = false
%      opts.verbose logical = false
%      opts.writejson logical = true
%  Returns:
%      filename of NIfTI in same folder as 4dfp
%
%  Created 29-Nov-2022 17:53:46 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.13.0.2105380 (R2022b) Update 2 for MACI64.  Copyright 2022 John J. Lee.

arguments
    fn_4dfp {mustBeFile}
    opts.noclobber logical = false
    opts.verbose logical = false
    opts.writejson logical = true
end
if ~endsWith(fn_4dfp, '.4dfp.hdr')
    fn_4dfp = strcat(myfileprefix(fn_4dfp), '.4dfp.hdr');
    assert(isfile(fn_4dfp), ...
        'fourdfp2nifti: could not find required file %s', fn_4dfp)
end

%% convert

ic = mlfourd.ImagingContext2(fn_4dfp);
nii = ic.nifti;
fn_nii = nii.fqfn;
fn_json = strcat(nii.fqfp, '.json');

if opts.verbose
    %% be verbose
    fprintf('fourdfp2nii: found %s with contents:\n', fn_4dfp)
    disp(nii)
    try
        fprintf('hdr.hk:\n')
        disp(nii.hdr.hk)
        fprintf('hdr.dime:\n')
        disp(nii.hdr.dime)
        fprintf('hdr.hist:\n')
        disp(nii.hdr.hist)
        if isfield(nii.hdr, 'extra')
            fprintf('hdr.extra:\n')
            disp(nii.hdr.extra)
        end
        fprintf('json_metadata:\n')
        disp(nii.json_metadata)
        if isfield(nii, 'original')
            fprintf('original:\n')
            disp(nii.original)
        end
    catch ME
        handwarning(ME)
    end
end

if ~isfile(fn_nii) || ~opts.noclobber
    %% save NIfTI
    save(nii, savelog=false)
    fprintf('fourdfp2nifti: wrote %s\n', fn_nii)
end

if opts.writejson && (~isfile(fn_json) || ~opts.noclobber)
    %% write json
    try

        imgrec = strcat(nii.fqfp, '.4dfp.img.rec');
        if ~isfile(imgrec)
            s = struct('rec', 'de novo from fourdfp2nifti');
        else
            r = fileread(imgrec);
            s = struct('rec', sprintf(r));
            if opts.verbose
                fprintf('fourdfp2nii: found .img.rec with contents:\n')
                disp(s.rec)
            end
        end
        j = jsonencode(s, PrettyPrint=true);
        fid = fopen(fn_json, 'w');
        fprintf(fid, j);
        fclose(fid);
        fprintf('fourdfp2nifti: wrote %s\n', fn_json)
    catch ME
        handwarning(ME)
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/fourdfp2nifti.m] ======  

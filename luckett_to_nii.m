function ic = luckett_to_nii(varargin)
%% LUCKETT_TO_NII converts mat/hdr/img files to mlfourd.ImagingContext2 with mlfourd.InnerNIfTI.
%  Usage:  ic2 = lucket_to_4dfp('data.hdr')
%  @param required filename
%  @param atlas is a 4dfp-filename | '111' | '222' | '333'.  Default is '333'.
%  @return writes NIfTI with identical fileprefix, clobbering any existing files.
%  @return mlfourd.ImagingContext2.
%
 %% developed on Matlab 9.8.0.1417392 (R2020a) Update 4.  Copyright 2020 John Joowon Lee.

    ip = inputParser;
    addRequired(ip, 'filename', @(x) contains(x, '.hdr') || contains(x, '.mat'))
    addParameter(ip, 'atlas', '333', @ischar)
    parse(ip, varargin{:})
    ipr = ip.Results;

    [pth,fp,x] = myfileparts(ipr.filename);
    atl = atlasContext(ipr.atlas);
    atl = atl.nifti;

    if strcmp(x, '.mat')
        try
            m = load(ipr.filename, 'img');
            sz = size(m.img);
            assert(numel(atl.img) == sz(1))
            atl.img = squeeze(reshape(m.img, [size(atl) sz(2)]));
        catch ME
            handwarning(ME)
            m = load(ipr.filename, 'dat');
            sz = size(m.dat);
            assert(numel(atl.img) == sz(1))
            atl.img = squeeze(reshape(m.dat, [size(atl) sz(2)]));
        end
        atl.img = flip(atl.img, 2);     
        atl.filepath = pth;
        atl.fileprefix = fp;
        ic = mlfourd.ImagingContext2(atl);
        return
    end
    
    ifc = mlfourd.ImagingFormatContext(ipr.filename); % read 2-file NIfTI
    atl.img = flip(ifc.img, 2);
    atl.filepath = pth;
    atl.fileprefix = fp;
    ic = mlfourd.ImagingContext2(atl);
end

function ic = atlasContext(atl)
    switch atl
        case '111'
            atl = fullfile(getenv('REFDIR'), '711-2B_111.nii.gz');
        case '222'
            atl = fullfile(getenv('REFDIR'), '711-2B_222.nii.gz');
        case '333'
            atl = fullfile(getenv('REFDIR'), '711-2B_333.nii.gz');
        otherwise
            assert(isfile(atl))
    end
    ic = mlfourd.ImagingContext2(atl);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de)
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/lucket_to_4dfp.m] ======

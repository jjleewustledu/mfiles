function ic = luckett_to_4dfp(varargin)
%% LUCKETT_TO_4DFP converts mat/hdr/img files to mlfourd.ImagingContext2 with mlfourdfp.InnerFourdfp.
%  Usage:  ic2 = lucket_to_4dfp('data.hdr')
%  @param required filename.
%  @param optional objname; default is '' and first availabe object will be loaded.
%  @param atlas is a 4dfp-filename | '111' | '222' | '333'.  Default is '333'.
%  @return writes 4dfp with identical fileprefix, clobbering any existing files.
%  @return mlfourd.ImagingContext2.
%
 %% developed on Matlab 9.8.0.1417392 (R2020a) Update 4.  Copyright 2020 John Joowon Lee.

    ip = inputParser;
    addRequired(ip, 'filename', @(x) contains(x, '.hdr') || contains(x, '.mat'))
    addOptional(ip, 'objname', '', @ischar)
    addParameter(ip, 'atlas', '333', @ischar)
    parse(ip, varargin{:})
    ipr = ip.Results;

    [pth,fp,x] = myfileparts(ipr.filename);
    atl = atlasContext(ipr.atlas);
    atl = atl.fourdfp;

    if strcmp(x, '.mat')
        m = load(ipr.filename);
        f = fields(m);
        if isempty(ipr.objname)
            obj = m.(f{1});
        elseif contains(f, ipr.objname)
            obj = m.(ipr.objname);
        end
        sz = size(obj);  
        if length(sz) == 2 && sz(2) > sz(1)
            obj = obj';
            sz = size(obj);
        end
        if numel(atl.img) == sz(1)            
            if length(sz) == 2
                atl.img = squeeze(reshape(obj, [size(atl) sz(2)]));
            else                
                atl.img = squeeze(reshape(obj, size(atl)));
            end
        else
            assert(numel(atl.img) == prod(sz(1:3)))
            if length(sz) == 4
                atl.img = squeeze(reshape(obj, [size(atl) sz(4)]));
            else
                atl.img = squeeze(reshape(obj, size(atl)));
            end
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
            atl = fullfile(getenv('REFDIR'), '711-2B_111.4dfp.hdr');
        case '222'
            atl = fullfile(getenv('REFDIR'), '711-2B_222.4dfp.hdr');
        case '333'
            atl = fullfile(getenv('REFDIR'), '711-2B_333.4dfp.hdr');
        otherwise
            assert(isfile(atl))
    end
    ic = mlfourd.ImagingContext2(atl);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de)
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/lucket_to_4dfp.m] ======

function collection = prototype2(rindices)

    colhead = '\#\s+ColHeaders\s+Index\s+SegId\s+NVoxels\s+Volume_mm3\s+StructName\s+Mean\s+StdDev\s+Min\s+Max\s+Range';
    SEGSTATS_EXP = [       colhead ...
                           rgxnname('index') ...
                           rgxnname('segid') ...
                           rgxnname('nvoxels') ...
                           rgxnname('volume_mm3') ...
                           '\s+(?<structname>\w+\d*)' ...
                           rgxnname('mean') ...
                           rgxnname('stddev') ...
                           rgxnname('min') ...
                           rgxnname('max') ...
                           rgxnname('range')];
    SUBJECTS_DIR = '/Volumes/PassportStudio2/test/np755';
    setenv('SUBJECTS_DIR', SUBJECTS_DIR);
    subjid   = 'mm01-020_p7377_2009feb5';
    subjdir  = fullfile(SUBJECTS_DIR, subjid, 'surf');
    T1prefix = 't1_005'; 
    averid   = 'fsaverage';
    averdir  = fullfile(SUBJECTS_DIR, averid, 'surf');
    T1       = fullfile(SUBJECTS_DIR, subjid, 'fsl', [T1prefix '.nii.gz']);
    regfile  = fullfile(subjdir, [T1prefix '_to_' averid '.dat']);
    collection = containers.Map(rindices, zeros(size(rindices)));

    cd(averdir);
    mlbash(sprintf('fslregister --s %s --mov %s --reg %s', averid, T1, regfile));
    
    cd(subjdir);
    hemis = { 'lh' 'rh' };
    for h = 1:length(hemis)
        system(sprintf( ...
           'mri_surf2surf --s %s --trgsubject %s --hemi %s --sval %s.thickness --tval %s --noreshape', ...
            subjid, averid, hemis{h}, hemis{h}, thfile(hemis{h})));
    end
    
    cd(fullfile(SUBJECTS_DIR, subjid, 'surf'));
    for r = 1:size(rindices,2);
        for h = 1:length(hemis)
            roilbl  = ['roi_' num2str(rindices(h, r))];
            fqroi   = fullfile(SUBJECTS_DIR, subjid, 'fsl', [roilbl '.nii.gz']);
            segfile = fullfile(subjdir, [hemis{h} '.' averid '.' roilbl '.mgh']);
            if (lexist(fqroi))
                try
                    system(sprintf( ...
                        'mri_vol2surf --mov %s --reg %s --projdist-max 0 1 0.1 --interp nearest --hemi %s --out %s --noreshape', ...
                        fqroi, regfile, hemis{h}, segfile));
                    sumfile = fullfile(subjdir, ['segstats_' hemis{h} '_' roilbl '.txt']);
                catch ME2
                    handwarning(ME2, stderr);
                end
                try
                    [~,stderr] = system(sprintf( ...
                    'mri_segstats --seg %s --in %s --excludeid 0 --sum %s', ...
                          segfile, thfile(hemis{h}), sumfile));
                    names = regexp( ...
                        mlio.TextIO.textfileToString(sumfile), SEGSTATS_EXP,'names');
                    disp(struct2str(names))
                catch ME
                    handwarning(ME, stderr);
                end
                if (~isempty(names) && isfield(names, 'mean'))
                    collection(rindices(h, r)) = str2double(names.mean); end;
            end
        end
    end
    
    
    
    function fqfn = thfile(hemi)
        fqfn = fullfile(subjdir, [hemi '.thickness.' averid '.mgh']);
    end

    function rgx = rgxnname(lbl)
        rgx = ['\s+(?<' lbl '>\d+\.?\d*)'];
    end
end


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/prototype.m] ====== 
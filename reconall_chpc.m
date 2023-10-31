function [s__,r__] = reconall_chpc()

    import mlperfusion.*;
    if contains(computer, 'MACI64')
        subjectsDir = '/Volumes/SeagateBP5/powers/np497/jjlee'; 
        diary(fullfile(subjectsDir, sprintf('%s_diary_%s.log', mfilename, datestr(now, 30)))); 
    else
        subjectsDir = '/scratch/jjlee/powers/np497/jjlee';
        setenv('SUBJECTS_DIR', subjectsDir);
    end
    s__ = cell(1,24);
    r__ = cell(1,24);

    parfor r = 2:24
        sessions  = { ...
            'test' ...
            'p5999' 'p6004' 'p6012' 'p6021' 'p6042' 'p6047' 'p6146' 'p6154' 'p6169' 'p6173' ...
            'p6189' 'p6248' 'p6253' 'p6320' 'p6324' 'p6352' 'p6354' 'p6359' 'p6374' 'p6381' ...
            'p6389' 'p6517' 'p6606'};
        try
            cd(subjectsDir);
            mpr = fullfile(subjectsDir, [sessions{r} '_mprage.nii.gz']);
            if (~lexist(mpr, 'file'))                
                mpr = fullfile(subjectsDir, [sessions{r} '_mprage1.nii.gz']);
            end
            assert(lexist(mpr, 'file'));
            fprintf('%s is working with %s from pwd->%s\n', mfilename, mpr, pwd);
            [s__{r},r__{r}] = mlbash(sprintf( ...
                '/act/freesurfer-5.3.0/bin/recon-all -all -i %s -subjid %s -sd %s >> reconall_%s.log 2>&1\n', ...
                mpr, sessions{r}, subjectsDir, sessions{r}));
        catch ME
            handwarning(ME);
        end
    end
    
    cd(subjectsDir);
    save(fullfile(subjectsDir, sprintf('%s_%s.mat', mfilename, datestr(now, 30))), '-v7.3');    
    if contains(computer, 'MAC')
        diary off; 
    end
    
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/unpacksdcmdir.m] ======  

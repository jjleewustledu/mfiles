function construct_Ks_wmparc1(subjectsExpr, Nthreads)

import mlraichle.*
import mlraichle.AerobicGlycolysisKit.*
import mlraichle.DispersedAerobicGlycolysisKit.*

if ischar(Nthreads)
    Nthreads = str2double(Nthreads);
end

registry = MatlabRegistry.instance(); %#ok<NASGU>
subjectsDir = '/data/nil-bluearc/raichle/PPGdata/jjlee/Singularity/subjects';
setenv('SUBJECTS_DIR', subjectsDir)
setenv('PROJECTS_DIR', fileparts(subjectsDir))
pwd1 = pushd(subjectsDir);

idx = 1;
subjects = globFoldersT(subjectsExpr); % e.g., 'sub-S3*'
for sub = subjects
    pwd0 = pushd(fullfile(subjectsDir, sub{1}));
    subd = mlraichle.SubjectData('subjectFolder', sub{1});
    sesfs = subd.subFolder2sesFolders(sub{1});

    for ses = sesfs
        try
            sesd = SessionData( ...
                'studyData', StudyData(), ...
                'projectData', ProjectData('sessionStr', ses{1}), ...
                'subjectData', subd, ...
                'sessionFolder', ses{1}, ...
                'tracer', 'FDG', ...
                'ac', true);            
            if sesd.datetime < mlraichle.StudyRegistry.instance.earliestCalibrationDatetime
                continue
            end
            fdg = sesd.fdgOnAtlas('typ', 'mlfourd.ImagingContext2');
            DispersedAerobicGlycolysisKit.ic2mat(fdg)
            
            filesys(idx).sub = sub{1}; %#ok<AGROW>
            filesys(idx).ses = ses{1}; %#ok<AGROW>            
            idx = idx + 1;
        catch ME
            handwarning(ME)
        end
    end
    popd(pwd0)
end

parfor (p = 1:length(filesys), Nthreads)    
    try
        [ks, msk] = DispersedAerobicGlycolysisKit.constructKsByWmparc1( ...
            fullfile('subjects', filesys(p).sub), [], 'sessionsExpr', filesys(p).ses); % memory ~ 5.5 GB
        ksc = DispersedAerobicGlycolysisKit.iccrop(ks, 1:4);
        DispersedAerobicGlycolysisKit.ic2mat(ksc)
        DispersedAerobicGlycolysisKit.ic2mat(msk)
        
        [cmrglc,chi] = DispersedAerobicGlycolysisKit.constructCmrglc( ...
            fullfile('subjects', filesys(p).sub), [], 'sessionsExpr', filesys(p).ses);
        DispersedAerobicGlycolysisKit.ic2mat(chi)
        DispersedAerobicGlycolysisKit.ic2mat(cmrglc)
    catch ME
        handwarning(ME)
    end
end

popd(pwd1)

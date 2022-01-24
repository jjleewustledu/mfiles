function construct_repairs(subjectsExpr, Nthreads)
%% e.g. construct_repairs('sub-S3*', 16)

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
            sesd = mlraichle.SessionData( ...
                'studyData', mlraichle.StudyData(), ...
                'projectData', mlraichle.ProjectData('sessionStr', ses{1}), ...
                'subjectData', subd, ...
                'sessionFolder', ses{1}, ...
                'tracer', 'FDG', ...
                'ac', true, ...
                'region', 'wmparc1');            
            if sesd.datetime < mlraichle.StudyRegistry.instance.earliestCalibrationDatetime
                continue
            end
%            fdg = sesd.fdgOnAtlas('typ', 'mlfourd.ImagingContext2');
%            fdg = fdg.blurred(4.3);
%            DispersedAerobicGlycolysisKit.ic2mat(fdg)
            
            filesys(idx).sub = sub{1}; %#ok<AGROW>
            filesys(idx).ses = ses{1}; %#ok<AGROW>
            filesys(idx).sesd = sesd; %#ok<AGROW>
            idx = idx + 1;
        catch ME
            handwarning(ME)
        end
    end
    popd(pwd0)
end

parfor (p = 1:length(filesys), Nthreads)    
%for p = 3:3
    try
%        DispersedAerobicGlycolysisKit.constructKsByWmparc1(filesys(p).sesd); % memory ~ 5.5 GB
        
        [cmrglc,Ks,msk] = DispersedAerobicGlycolysisKit.constructCmrglcAndSupportInfo(filesys(p).sesd);
    catch ME
        handwarning(ME)
    end
end

popd(pwd1)

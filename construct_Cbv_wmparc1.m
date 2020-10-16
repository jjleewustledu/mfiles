function construct_Cbv_wmparc1(subjectsExpr, Nthreads)
%% e.g. construct_Cbv_wmparc1('sub-S58163*', 16)

import mlraichle.*
import mlraichle.AerobicGlycolysisKit.*
import mlraichle.DispersedAerobicGlycolysisKit.*

if ischar(Nthreads)
    Nthreads = str2double(Nthreads);
end

registry = MatlabRegistry.instance(); %#ok<NASGU>
subjectsDir = fullfile(getenv('SINGULARITY_HOME'), 'subjects');
setenv('SUBJECTS_DIR', subjectsDir)
setenv('PROJECTS_DIR', fileparts(subjectsDir))
pwd1 = pushd(subjectsDir);

idx = 1;
subjects = globFoldersT(subjectsExpr); % e.g., 'sub-S3*'
for sub = subjects
    pwd0 = pushd(fullfile(subjectsDir, sub{1}));
    subd = mlraichle.SubjectData('subjectFolder', sub{1});
    sesfs = subd.subFolder2sesFolders(sub{1});

%    ses = {sesfs{3}};
    for ses = sesfs
        try
            sesd = SessionData( ...
                'studyData', StudyData(), ...
                'projectData', ProjectData('sessionStr', ses{1}), ...
                'subjectData', subd, ...
                'sessionFolder', ses{1}, ...
                'tracer', 'OC', ...
                'ac', true, ...
                'region', 'wmparc1');            
            if sesd.datetime < mlraichle.StudyRegistry.instance.earliestCalibrationDatetime
                continue
            end
            hofn = sesd.hoOnAtlas();
            if ~isfile(hofn)
                sesd.jitOn222(hofn)
            end
            if ~isfile([myfileprefix(hofn) '_b43.mat'])
                ho = mlfourd.ImagingContext2(hofn);
                ho = ho.blurred(4.3);
                DispersedAerobicGlycolysisKit.ic2mat(ho)
            end
            filesys(idx).sesd = sesd; %#ok<AGROW>
            idx = idx + 1;
        catch ME
            handexcept(ME)
        end
    end
    popd(pwd0)
end

% for p = 1:length(filesys) 
parfor (p = 1:length(filesys), Nthreads)    
    try
        DispersedAerobicGlycolysisKit.constructCbvByRegion(filesys(p).sesd); % memory ~ 5.5 GB
        
    catch ME
        handwarning(ME)
    end
end

popd(pwd1)

function construct_Cbf_wholebrain(subjectsExpr, varargin)
%% e.g. construct_Cbf_wholebrain('sub-S58163*', 16)

import mlraichle.*
import mlraichle.AerobicGlycolysisKit.*
import mlraichle.DispersedAerobicGlycolysisKit.*

ip = inputParser;
addRequired(ip, 'subjectsExpr', @ischar)
addOptional(ip, 'Nthreads', @(x) isnumeric(x) || ischar(x))
addParameter(ip, 'region', 'wholebrain', @ischar) % 'wbrain1'
parse(ip, subjectsExpr, varargin{:})
ipr = ip.Results;
if ischar(ipr.Nthreads)
    ipr.Nthreads = str2double(ipr.Nthreads);
end

registry = MatlabRegistry.instance(); %#ok<NASGU>
subjectsDir = fullfile(getenv('SINGULARITY_HOME'), 'subjects');
setenv('SUBJECTS_DIR', subjectsDir)
setenv('PROJECTS_DIR', fileparts(subjectsDir))
pwd1 = pushd(subjectsDir);

idx = 1;
subjects = globFoldersT(ipr.subjectsExpr); % e.g., 'sub-S3*'
for sub = subjects
    pwd0 = pushd(fullfile(subjectsDir, sub{1}));
    subd = mlraichle.SubjectData('subjectFolder', sub{1});
    sesfs = subd.subFolder2sesFolders(sub{1});

    ses = {sesfs{3}};
%    for ses = sesfs
        try
            sesd = SessionData( ...
                'studyData', StudyData(), ...
                'projectData', ProjectData('sessionStr', ses{1}), ...
                'subjectData', subd, ...
                'sessionFolder', ses{1}, ...
                'tracer', 'HO', ...
                'ac', true, ...
                'region', ipr.region);            
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
%    end
    popd(pwd0)
end

for p = 1:length(filesys) 
%parfor (p = 1:length(filesys), ipr.Nthreads)    
    try
        DispersedAerobicGlycolysisKit.constructFsWholebrain(filesys(p).sesd); % memory ~ 5.5 GB
    catch ME
        handwarning(ME)
    end
end

popd(pwd1)

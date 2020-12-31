function construct_Cmro2_wholebrain(subjectsExpr, varargin)
%% e.g. construct_Cmro2_wholebrain('sub-S58163*', 16)

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
                'tracer', 'OO', ...
                'ac', true, ...
                'region', ipr.region);            
            if sesd.datetime < mlraichle.StudyRegistry.instance.earliestCalibrationDatetime
                continue
            end
            oofn = sesd.ooOnAtlas();
            if ~isfile(oofn)
                sesd.jitOn222(oofn)
            end
            if ~isfile([myfileprefix(oofn) '_b43.mat'])
                oo = mlfourd.ImagingContext2(oofn);
                oo = oo.blurred(4.3);
                DispersedAerobicGlycolysisKit.ic2mat(oo)
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
        DispersedAerobicGlycolysisKit.constructOsWholebrain(filesys(p).sesd); % memory ~ 5.5 GB
    catch ME
        handwarning(ME)
    end
end

popd(pwd1)

function construct_Cbf(subjectsExpr, varargin)
%% constructs CBF maps for parcellations or for voxels.
%  e.g. construct_Cbf('sub-S58163'
%  e.g. construct_Cbf('sub-S58163*', 16, 'region', 'wmparc1', 'construction', 'constructFsByRegion')
%  e.g. construct_Cbf('sub-S58163*',     'region', 'wbrain1', 'construction', 'constructCbfByQuadModel')

import mlraichle.*
import mlraichle.AerobicGlycolysisKit.*
import mlraichle.DispersedAerobicGlycolysisKit.*

ip = inputParser;
addRequired(ip, 'subjectsExpr', @ischar)
addOptional(ip, 'Nthreads', 1, @(x) isnumeric(x) || ischar(x))
addParameter(ip, 'metric', '', @ischar)
addParameter(ip, 'region', 'wmparc1', @ischar)
addParameter(ip, 'construction', 'constructFsByRegion', @ischar)
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

switch ipr.construction
    case 'constructFsByRegion'
        fh = @DispersedAerobicGlycolysisKit.constructFsByRegion;
        ipr.metric = 'fs';
    case 'constructGsByRegion'
        fh = @DispersedAerobicGlycolysisKit.constructGsByRegion;
        ipr.metric = 'gs';
    case 'constructCbfByQuadModel'
        fh = @AerobicGlycolysisKit.constructCbfByQuadModel;        
        ipr.metric = 'cbfquad';
    otherwise
        error('mfiles:ValueError', 'construct_Cbf.ipr.construction->%s', ipr.construction)
end

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
                'metric', ipr.metric, ...
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

% do construction
if 1 == ipr.Nthreads
    for p = 1:length(filesys)
        try
            fh(filesys(p).sesd); % memory ~ 5.5 GB
        catch ME
            handwarning(ME)
        end
    end
else
    parfor (p = 1:length(filesys), ipr.Nthreads)
        try
            fh(filesys(p).sesd); % memory ~ 5.5 GB
        catch ME
            handwarning(ME)
        end
    end
end

popd(pwd1)

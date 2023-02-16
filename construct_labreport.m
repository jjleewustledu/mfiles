function construct_labreport(subjectsExpr)
%% e.g. construct_labreport('sub-S3*')

import mlraichle.*

registry = MatlabRegistry.instance(); %#ok<NASGU>
subjectsDir = '/data/nil-bluearc/raichle/PPGdata/jjlee/Singularity/subjects';
setenv('SUBJECTS_DIR', subjectsDir)
setenv('PROJECTS_DIR', fileparts(subjectsDir))
pwd1 = pushd(subjectsDir);

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
            radm = mlpet.CCIRRadMeasurements.createFromSession(sesd);
            lab.hct = str2double(radm.laboratory{'Hct', 1}{1});
            rows = contains(radm.laboratory.Properties.RowNames, 'glc FDG');
            glc = cellfun(@str2double, radm.laboratory{rows, 1});
            lab.glc = mean(glc(~isnan(glc)));
            matfn = [myfileprefix(sesd.fdgOnAtlas()) '_b43.mat'];
            matfn = strrep(matfn, 'fdgdt', 'labdt');
            save(matfn, 'lab')
        catch ME
            handexcept(ME)
        end
    end
    popd(pwd0)
end

popd(pwd1)

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
    subd = SubjectData('subjectFolder', sub{1});
    sesfs = subd.subFolder2sesFolders(sub{1});

    for ses = sesfs
        try
            sesd = SessionData( ...
                'studyData', StudyData(), ...
                'projectData', ProjectData('sessionStr', ses{1}), ...
                'subjectData', subd, ...
                'sessionFolder', ses{1}, ...
                'tracer', 'FDG', ...
                'ac', true, ...
                'region', 'wmparc1');            
            if sesd.datetime < StudyRegistry.instance.earliestCalibrationDatetime
                continue
            end            
            radm = mlpet.CCIRRadMeasurements.createFromSession(sesd);
            lab.hct = str2double(radm.fromPamStone{'Hct', 1}{1});
            rows = contains(radm.fromPamStone.Properties.RowNames, 'glc FDG');
            glc = cellfun(@str2double, radm.fromPamStone{rows, 1});
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

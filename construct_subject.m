function construct_subject(subFolder)
    %% CONSTRUCT_SUBJECT uses t4_resolve to co-register PET images for a subject.  It co-registers all iso-tracer images,
    %  then co-registers all inter-tracers images.

    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository $URL$,  
    %% developed on Matlab 9.5.0.1067069 (R2018b) Update 4.  Copyright 2019 John Joowon Lee. 

    import mlraichle.*
    import mlsystem.DirTool
    setenv('PROJECTS_DIR', '/scratch/jjlee/Singularity')
    setenv('SUBJECTS_DIR', '/scratch/jjlee/Singularity/subjects')
    subPath = fullfile(getenv('SUBJECTS_DIR'), subFolder, '');
    
    pwd0 = pushd(subPath);
    subData = SubjectData('subjectFolder', subFolder);
    sesFold = subData.subFolder2sesFolder(subFolder);
    sesData = SessionData( ...
        'studyData', StudyData(), ...
        'projectData', ProjectData('sessionStr', sesFold), ...
        'subjectData', subData, ...
        'sessionFolder', sesFold, ...
        'tracer', 'FDG', ...
        'ac', true); % referenceTracer        
    srb = mlpet.SubjectResolveBuilder('subjectData', subData, 'sessionData', sesData);
    if ~srb.isfinished
        srb.align
    end
    popd(pwd0)

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/construct_subjects.m] ======  

end
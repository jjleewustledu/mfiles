function construct_sessions(subFolder)
%% CONSTRUCT_SESSIONS ... 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.5.0.1067069 (R2018b) Update 4.  Copyright 2019 John Joowon Lee. 

    import mlraichle.*
    import mlsystem.DirTool
    setenv('PROJECTS_DIR', '/scratch/jjlee/Singularity')
    setenv('SUBJECTS_DIR', '/scratch/jjlee/Singularity/subjects')
    subPath = fullfile(getenv('SUBJECTS_DIR'), subFolder, '');
    
    pwd0 = pushd(subPath);
    dt = DirTool('ses-*');
    for ses = dt.dns
        
        pwd1 = pushd(ses{1});
        dt1 = DirTool('*_DT*.000000-Converted-AC');
        if ~isempty(dt1.dns) 
            sesData = SessionData( ...
                'studyData', StudyData(), ...
                'projectData', ProjectData('sessionStr', ses{1}), ...
                'subjectData', SubjectData('subjectFolder', subFolder), ...
                'sessionFolder', ses{1}, ...
                'tracer', 'FDG', ...
                'ac', true); % referenceTracer
            srb = mlpet.SessionResolveBuilder('sessionData', sesData);
            if ~srb.isfinished
                srb.align;
            end
        end
        popd(pwd1)
    end
    popd(pwd0)

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/construct_sessions.m] ======  

end
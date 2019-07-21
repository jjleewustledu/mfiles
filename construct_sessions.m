function construct_sessions(subFolder)
%% CONSTRUCT_SESSIONS ... 
function construct_sessions(subFolder, varargin)
%% CONSTRUCT_SESSIONS 
%  @param required subFolder is a folder.
%  @param aufbauSubjectsDir is logical (default false); it initiates SubjectData.aufbauSubjectsDir and immediately returns.
%  @param aufbauSessionPath is logical (default false); it initiates SubjectData.aufbauSessionPath and immediately returns.

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.5.0.1067069 (R2018b) Update 4.  Copyright 2019 John Joowon Lee. 

    import mlraichle.*
    import mlsystem.DirTool
    setenv('PROJECTS_DIR', '/scratch/jjlee/Singularity')
    setenv('SUBJECTS_DIR', '/scratch/jjlee/Singularity/subjects')
    subPath = fullfile(getenv('SUBJECTS_DIR'), subFolder, '');
    
    ip = inputParser;
    addParameter(ip, 'aufbauSubjectsDir', false, @islogical);
    addParameter(ip, 'aufbauSessionPath', false, @islogical);
    addParameter(ip, 'experimentPattern', '_E', @ischar)
    addParameter(ip, 'sessionPattern', 'ses-*', @ischar)
    addParameter(ip, 'tracerPattern', 'FDG_DT*.000000-Converted-AC', @ischar)
    parse(ip, varargin{:})
    
    if ip.Results.aufbauSubjectsDir
        subjectData = mlraichle.SubjectData();
        subjectData.aufbauSubjectsDir();
        return
    end
    if ip.Results.aufbauSessionPath
        subjectData = mlraichle.SubjectData('subjectFolder', subFolder);
        pth = fullfile(getenv('SUBJECTS_DIR'), subFolder);
        subID = subFolder2subID(subjectData, subFolder);
        subjectData.aufbauSessionPath(pth, subjectData.subjectsJson.(subID), 'experimentPattern', ip.Results.experimentPattern);
        return
    end
    
    pwd0 = pushd(subPath);
    dt = DirTool(ip.Results.sessionPattern);
    for ses = dt.dns
        
        pwd1 = pushd(ses{1});
        if mlpet.SessionResolveBuilder.validTracerSession(ip.Results)
            sesData = SessionData( ...
                'studyData', StudyData(), ...
                'projectData', ProjectData('sessionStr', ses{1}), ...
                'subjectData', SubjectData('subjectFolder', subFolder), ...
                'sessionFolder', ses{1}, ...
                'tracer', 'FDG', ...
                'ac', true); % referenceTracer         
            %mlpet.SessionResolveBuilder.makeClean()
            srb = mlpet.SessionResolveBuilder('sessionData', sesData);   
            if ~srb.isfinished
                srb.align;
            end
        end
        popd(pwd1)
    end
    popd(pwd0)
    function sid = subFolder2subID(sdata, sfold)
        json = sdata.subjectsJson;
        for an_sid = asrow(fields(json))
            if lstrfind(json.(an_sid{1}).sid, sfold(5:end))
                sid = an_sid{1};
                return
            end
        end
    end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/construct_sessions.m] ======  

end
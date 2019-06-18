function resolve_sessions(varargin)
    %% RESOLVE_SESSIONS     
    %  @param aufbauSubjectsDir symlinks in subjectPath/sessionFolder/TRACER_DT20190101000000.000000-Converted-AC to
    %  projectPath/sessionFolder/TRACER_DT20190101000000.000000-Converted-AC.
    
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository $URL$,  
    %% developed on Matlab 9.5.0.1067069 (R2018b) Update 4.  Copyright 2019 John Joowon Lee. 

    import mlsystem.* mlraichle.*; %#ok<NSTIMP>
    
    %% setenv PROJECTS_DIR is not compatible with Docker+Singularity
    %  setenv('PROJECTS_DIR', '/scratch/jjlee/Singularity');
    %  setenv('SUBJECTS_DIR', '/scratch/jjlee/Singularity/subjects');
            
    ip = inputParser;
    ip.KeepUnmatched = true;
    addOptional( ip, 'subjectsExpr', 'sub-*', @ischar);
    addOptional( ip, 'sessionsExpr', 'ses-*', @ischar);
    addOptional( ip, 'ac', []);
    addParameter(ip, 'aufbauSubjectsDir', []);
    addParameter(ip, 'ignoreFinishMark', false, @islogical);
    addParameter(ip, 'compAlignMethod', '', @ischar); % align_multiSpectral
    parse(ip, varargin{:});
    ipr = adjustParameters(ip.Results);
  
    if ~isempty(ip.Results.aufbauSubjectsDir)
        subjectData = mlraichle.SubjectData();
        subjectData.aufbauSubjectsDir();
        return
    end
    
    % resolve tracers within sessionFolders
    dtsubj = DirTool2(fullfile(getenv('SUBJECTS_DIR'), ipr.subjectsExpr));
    for isubj = 1:length(dtsubj.fqdns)
        dtsess = DirTool2(fullfile(dtsubj.fqdns{isubj}, ipr.sessionsExpr));
        for isess = 1:length(dtsess.fqdns)
            pwd0 = pushd(dtsess.fqdns{isess});              

            try
                sessd = constructSessionData(ipr, dtsubj.dns{isubj}, dtsess.dns{isess});
                workpath = fullfile(sessd.subjectPath, sessd.sessionFolder, '');
                dt = mlsystem.DirTool2(fullfile(workpath, '*-Converted-AC'));
                if ~isempty(dt.dns)
                    fprintf('resolve_sessions:\n');
                    fprintf([evalc('disp(sessd)') '\n']);
                    fprintf(['\tworkpath->' workpath '\n']);
                    srb = mlpet.SessionResolveBuilder('sessionData', sessd);
                    srb.alignCrossModal;
                end
            catch ME
                dispwarning(ME);
                getReport(ME);
            end
               
            popd(pwd0);
        end
    end
    
    %% INTERNAL FUNC

    function ipr = adjustParameters(ipr)
        assert(isstruct(ipr));
        if lstrfind(ipr.subjectsExpr, filesep)
            ss = strsplit(ipr.subjectsExpr, filesep);
            assert(2 == length(ss));
            ipr.subjectsExpr = ss{1};
            ipr.sessionsExpr = ss{2};
        end
        results = {'subjectsExpr' 'sessionsExpr'};
        for r = 1:length(results)
            if (~lstrfind(ipr.(results{r}), '*'))
                ipr.(results{r}) = [ipr.(results{r}) '*'];
            end
        end
        if (ischar(ipr.ac))
            ipr.ac = strcmpi(ipr.ac, 'true');
        end
    end
    function sessd = constructSessionData(ipr, subjf, sessf)
        import mlraichle.*;
        sessd = SessionData( ...
            'studyData', StudyData, ...
            'subjectData', SubjectData('subjectFolder', subjf), ...
            'sessionFolder', sessf, ...
            'tracer', 'FDG', 'ac', true); % referenceTracer
        if (~isempty(ipr.compAlignMethod))
            sessd.compAlignMethod = ipr.compAlignMethod;
        end
        if (~isempty(ipr.ignoreFinishMark))
            sessd.ignoreFinishMark = true;
        end
    end  

end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/resolve_sessions.m] ======  

function those = construct_resampling_restricted(varargin)
    %% CONSTRUCT_RESAMPLING_RESTRICTED supports t4_resolve for niftypet.  It is the top level of a Matlab Compiler Runtime project.
    %  Usage:  construct_resolved([projectsExpr, sessionsExpr, tracerExpr, ac])
    %  e.g.:   >> construct_resolved('CCIR_00123', 'ses-E0012*', 'OO_DT20190101*-Converted-NAC*')
    %          >> construct_resolved('CCIR_00123/ses-E0012*/OO_DT20190101*-Converted-NAC*')
    %  
    %  @precondition fullfile(projectsDir, project, session, 'umapSynth_op_T1001_b43.4dfp.*') and
    %                         projectsDir := getenv('PROJECTS_DIR')
    %  @precondition files{.bf,.dcm} in fullfile(projectsDir, project, session, 'LM', '')
    %  @precondition files{.bf,.dcm} in fullfile(projectsDir, project, session, 'norm', '')
    %  @precondition FreeSurfer recon-all results in fullfile(projectsDir, project, session, 'mri', '')
    %
    %  @param projectsExpr is char, e.g., 'CCIR_00123' or globbed;
    %         it may also contain two filesep instances, prompting an interpretation such that
    %         projectsExpr == projectsExpr/sessionsExpr/tracerExp; sessionsExpr and tracerExpr will by consequently 
    %         ignored.
    %  @param sessionsExpr is char, e.g., 'ses-E01234' or globbed.
    %  @param tracersExpr is char, e.g., 'FDG_DT20000101090000.000000-Converted-NAC' or globbed.
    %  @param ac is logical or []; default := [].  
    %         Set to logical to constrain globbing attentuaion corection to '-NAC' or '-AC'.
    %  @return results in fullfile(projectsDir, project, session, tracer) 
    %          for elements of projectsExpr, sessionsExpr and tracerExpr.
    %  @return cell array of objects specified by mlraichle.TracerDirector2.constructResolved().
    %
    %  N.B.:  Setting environment vars PROJECTS_DIR or SUBJECTS_DIR is not compatible with many Docker or Singularity
    %         use cases.
    
    TRACERS = {'OC*' 'HO*' 'OO*'}; 
        
    import mlsystem.* mlraichle.*; %#ok<NSTIMP>
    import mlpet.DirToolTracer;
    ip = inputParser;
    ip.KeepUnmatched = true;
    addOptional( ip, 'projectsExpr', 'CCIR_*', @ischar);
    addOptional( ip, 'sessionsExpr', 'ses-*', @ischar);
    addOptional( ip, 'tracersExpr', TRACERS, @(x) ischar(x) || iscell(x));
    addOptional( ip, 'ac', []);
    addParameter(ip, 'ignoreFinishMark', true, @islogical);
    addParameter(ip, 'frameAlignMethod', '', @ischar); % align_10243
    addParameter(ip, 'compAlignMethod', '', @ischar); % align_multiSpectral
    addParameter(ip, 'fractionalImageFrameThresh', [], @(x) isnumeric(x) || ischar(x));
    parse(ip, varargin{:});
    ipr = adjustParameters(ip.Results);
    projExpr = ipr.projectsExpr;
    sessExpr = ipr.sessionsExpr;
    those = {};
    
    dtproj = DirTools(fullfile(mlraichle.StudyRegistry.instance.projectsDir, projExpr));
    for iproj = 1:length(dtproj.fqdns)
        dtsess = DirTools(fullfile(dtproj.fqdns{iproj}, sessExpr));
        for isess = 1:length(dtsess.fqdns)
            pwd0 = pushd(dtsess.fqdns{isess});
            dttrac = DirToolTracer('tracer', ipr.tracersExpr, 'ac', ipr.ac);
            for itrac = 1:length(dttrac.fqdns)
                try
                    sessd = constructSessionData(ipr, dtproj.dns{iproj}, dtsess.dns{isess}, dttrac.dns{itrac});
                    
                    %mlbash(sprintf('rm -rf E%i', sessd.supEpoch))                    
                    %mlbash(sprintf('rm -rf E1to%i', sessd.supEpoch))
                    
                    warning('off', 'MATLAB:subsassigndimmismatch');
                    rrrd = mlpet.ResamplingRestrictedResolveBuilder('sessionData', sessd);
                    rrrd.reconstituteFramesAC3
                    warning('on',  'MATLAB:subsassigndimmismatch');
                catch ME
                    dispwarning(ME)
                    getReport(ME)
                end
            end
            popd(pwd0);
        end
    end
    
    %% INTERNAL FUNC

    function ipr = adjustParameters(ipr)
        assert(isstruct(ipr));
        if lstrfind(ipr.projectsExpr, filesep)
            ss = strsplit(ipr.projectsExpr, filesep);
            assert(length(ss) >= 3);
            ipr.projectsExpr = ss{1};
            ipr.sessionsExpr = ss{2};
            ipr.tracersExpr = ss{3};
        end
        results = {'projectsExpr' 'sessionsExpr' 'tracersExpr'};
        for r = 1:length(results)
            if (~lstrfind(ipr.(results{r}), '*'))
                ipr.(results{r}) = [ipr.(results{r}) '*'];
            end
        end
        if ischar(ipr.ac)
            ipr.ac = strcmpi(ipr.ac, 'true');
        end
        if ischar(ipr.fractionalImageFrameThresh)
            ipr.fractionalImageFrameThresh = str2double(ipr.fractionalImageFrameThresh);            
        end
    end
    function sessd = constructSessionData(ipr, projf, sessf, scanf)
        sessd = mlraichle.SessionData( ...
            'studyData', mlraichle.StudyRegistry.instance, ...
            'projectData', mlraichle.ProjectData('sessionStr', sessf), ...
            'subjectData', mlraichle.SubjectData(), ...
            'sessionFolder', sessf, ...
            'scanFolder', scanf);
        if (~isempty(ipr.fractionalImageFrameThresh))
            sessd.fractionalImageFrameThresh = ipr.fractionalImageFrameThresh;
        end
        if (~isempty(ipr.frameAlignMethod))
            sessd.frameAlignMethod = ipr.frameAlignMethod;
        end
        if (~isempty(ipr.compAlignMethod))
            sessd.compAlignMethod = ipr.compAlignMethod;
        end
        if (~isempty(ipr.ignoreFinishMark))
            sessd.ignoreFinishMark = ipr.ignoreFinishMark;
        end
    end    
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

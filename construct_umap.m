function those = construct_umap(varargin)
    %% CONSTRUCT_UMAP supports niftypet.  It is the top level of a Matlab Compiler Runtime project.
    %  Usage:  construct_resolved([projectsExpr, sessionsExpr])
    %  e.g.:   >> construct_resolved('CCIR_00123', 'ses-E0012*')
    %  
    %  @precondition CT DICOM files in fullfile(subjectsDir, project, session, 'ct', '') and
    %                subjectsDir := getenv('PPG_SUBJECTS_DIR')
    %  @precondition FreeSurfer recon-all results in fullfile(subjectsDir, project, session, 'mri', '')
    %
    %  @param projectsExpr is char, e.g., 'CCIR_00123' or globbed.
    %  @param sessionsExpr is char, e.g., 'ses-E01234' or globbed.
    %  @return fullfile(subjectsDir, project, session, 'umapSynth_op_T1001_b43.4dfp.*').
    %  @return cell array of objects specified by mlraichle.TracerDirector2.constructUmaps().
    
    import mlsystem.* mlraichle.*; %#ok<NSTIMP>
    import mlpet.DirToolTracer;
    ip = inputParser;
    ip.KeepUnmatched = true;
    addOptional( ip, 'projectsExpr', 'CCIR_*', @ischar);
    addOptional( ip, 'sessionsExpr', 'ses-*', @ischar);
    addParameter(ip, 'compAlignMethod', '', @ischar); % align_multiSpectral
    parse(ip, varargin{:});
    ipr = adjustParameters(ip.Results);
    projExpr = ipr.projectsExpr;
    sessExpr = ipr.sessionsExpr;
    those = {};
    
    dtproj = DirTools(fullfile(RaichleRegistry.instance.projectsDir, projExpr));
    for iproj = 1:length(dtproj.fqdns)
        dtsess = DirTools(fullfile(dtproj.fqdns{iproj}, sessExpr));
        for isess = 1:length(dtsess.fqdns)
            pwd0 = pushd(dtsess.fqdns{isess});
            try
                sessd = constructSessionData(ipr, dtproj.dns{iproj}, dtsess.dns{isess});

                fprintf('construct_umap:\n');
                fprintf([evalc('disp(sessd)') '\n']);
                
                warning('off', 'MATLAB:subsassigndimmismatch');
                those{isess} = TracerDirector2.constructUmaps('sessionData', sessd);  %#ok<AGROW>
                warning('on',  'MATLAB:subsassigndimmismatch');
            catch ME
                dispwarning(ME)
                getReport(ME)
            end
            popd(pwd0);
        end
    end
    
    %% INTERNAL FUNC

    function ipr = adjustParameters(ipr)
        assert(isstruct(ipr));
        results = {'projectsExpr' 'sessionsExpr'};
        for r = 1:length(results)
            if (~lstrfind(ipr.(results{r}), '*'))
                ipr.(results{r}) = [ipr.(results{r}) '*'];
            end
        end
    end
    function sessd = constructSessionData(ipr, projf, sessf)
        import mlraichle.*;
        sessd = SessionData( ...
            'studyData', RaichleRegistry.instance, ...
            'projectFolder', projf, ...
            'sessionFolder', sessf);
        if (~isempty(ipr.compAlignMethod))
            sessd.compAlignMethod = ipr.compAlignMethod;
        end
    end    
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

function those = construct_resolved(varargin)
    %% CONSTRUCT_RESOLVED supports t4_resolve for niftypet.  It is the top level of a Matlab Compiler library project.
    %  Usage:  resolve_pet('sessionExpr', sessExpr, 'tracer', aTrac, 'ac', tf) 
    %  
    %  @precondition ct 4dfp in fullfile(getenv('SUBJECTS_DIR'), sessExpr); 
    %  listmode .bf/.dcm and umap folder of .dcm in 
    %  tracerLocation := fullfile(getenv('SUBJECTS_DIR'), sessExpr, vExpr, tracerFolder), e.g.,
    %  tracerFolder := 'FDG_V1-NAC' | 'FDG_V1-AC'.
    %
    %  @param sessionsExpr is char, e.g., 'ses-E00026'.
    %  @param tracer       is char, e.g., 'FDG'.
    %  @param ac, attentuaion corection, is logical.  Default := false.
    %  @return new filesystem tree at tracerLocation containing:  
    %  if not ac:  
    %      zoomed tracer 4dfp, epoch folders, logs, t4s, unzoomed umaps resolved to 
    %      no-attenuation-correction frame reconstructions;
    %  else:
    %      zoomed tracer 4dfp resolved to last frame of attenuation/scatter/randoms corrected reconstructions.
    %
    %
    %
    %  @param  named sessionsExp is char, specifying session directories to match by DirTool.
    %  @param  named visitsExp   is char, specifying visit   directories to match by DirTool.
    %  @param  named scanList    is numeric := trace scan indices.
    %  @param  named tracer      is char    and passed to SessionData.
    %  @param  named ac          is logical and passed to SessionData.
    %  @return those             is a cell-array of objects specified by factoryMethod.
    %  @return dtsess            is an mlsystem.DirTool for sessions.
    
    TRACERS = {'OC' 'HO' 'OO'}; %{'FDG'}; 
    AC = false;
        
    import mlsystem.* mlraichle.*; %#ok<NSTIMP>
    ip = inputParser;
    ip.KeepUnmatched = true;
    addParameter(ip, 'projectsExpr', 'CCIR_*', @ischar);
    addParameter(ip, 'sessionsExpr', 'ses-*', @ischar);
    addParameter(ip, 'tracer', TRACERS, @(x) ischar(x) || iscell(x));
    addParameter(ip, 'ac', AC);
    addParameter(ip, 'frameAlignMethod', '', @ischar); % align_10243
    addParameter(ip, 'compAlignMethod', '', @ischar); % align_multiSpectral
    addParameter(ip, 'fractionalImageFrameThresh', [], @isnumeric);
    parse(ip, varargin{:});
    ipr = adjustParameters(ip.Results);
    projExpr = ipr.projectsExpr;
    sessExpr = ipr.sessionsExpr;
    those = {};
    
    dtproj = DirTools(fullfile(RaichleRegistry.instance.projectsDir, projExpr));
    for iproj = 1:1 %length(dtproj.fqdns)
        dtsess = DirTools(fullfile(dtproj.fqdns{iproj}, sessExpr));
        for isess = 1:1 %length(dtsess.fqdns)
            pwd0 = pushd(dtsess.fqdns{isess});
            dttrac = mlpet.DirToolTracer('tracer', ipr.tracer, 'ac', ipr.ac);
            for itrac = 1:1 %length(dttrac.fqdns)
                try
                    sessd = constructSessionData(ipr, dtproj.dns{iproj}, dtsess.dns{isess}, dttrac.dns{itrac});
                    
                    fprintf('construct_resolved:\n');
                    fprintf([evalc('disp(sessd)') '\n']);
                    fprintf(['\tsessd.TracerLocation->' sessd.tracerLocation '\n']);
                    warning('off', 'MATLAB:subsassigndimmismatch');
                    those{isess,itrac} = TracerDirector2.constructResolved( ...
                        'sessionData', sessd, varargin{:});  %#ok<AGROW>
                    warning('on', 'MATLAB:subsassigndimmismatch');
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
        results = {'projectsExpr' 'sessionsExpr'};
        for r = 1:length(results)
            if (~lstrfind(ipr.(results{r}), '*'))
                ipr.(results{r}) = [ipr.(results{r}) '*'];
            end
        end
    end
    function sessd = constructSessionData(ipr, projf, sessf, tracf)
        import mlraichle.*;
        sessd = SessionData( ...
            'studyData', RaichleRegistry.instance, ...
            'projectFolder', projf, ...
            'sessionFolder', sessf, ...
            'tracerFolder', tracf);
        if (~isempty(ipr.fractionalImageFrameThresh))
            sessd.fractionalImageFrameThresh = ipr.fractionalImageFrameThresh;
        end
        if (~isempty(ipr.frameAlignMethod))
            sessd.frameAlignMethod = ipr.frameAlignMethod;
        end
        if (~isempty(ipr.compAlignMethod))
            sessd.compAlignMethod = ipr.compAlignMethod;
        end
    end    
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

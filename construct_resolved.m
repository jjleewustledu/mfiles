function construct_resolved(varargin)
    %% CONSTRUCT_RESOLVED supports t4_resolve for niftypet.  It is the top level of a Matlab Compiler Runtime project.
    %  Usage:  construct_resolved(<folders experssion>)
    %          e.g.:  >> construct_resolved('CCIR_00123/ses-E00123/OO_DT20190101.000000-Converted-NAC')    
    %          e.g.:  >> construct_resolved('CCIR_00123/ses-E0012*/OO_DT*-Converted-NAC')
    %  
    %  @precondition fullfile(projectsDir, project, session, 'umapSynth_op_T1001_b43.4dfp.*') and
    %                         projectsDir := getenv('PROJECTS_DIR')
    %  @precondition files{.bf,.dcm} in fullfile(projectsDir, project, session, 'LM', '')
    %  @precondition files{.bf,.dcm} in fullfile(projectsDir, project, session, 'norm', '')
    %  @precondition FreeSurfer recon-all results in fullfile(projectsDir, project, session, 'mri', '')
    %
    %  @param foldersExpr is char.
    %  @return results in fullfile(projectsDir, project, session, tracer) 
    %          for elements of projectsExpr, sessionsExpr and tracerExpr.
    %
    %  N.B.:  Setting environment vars PROJECTS_DIR or SUBJECTS_DIR is not compatible with many Docker or Singularity
    %         use cases.    

    ss = strsplit(varargin{1}, filesep);
    switch ss{1}
        case {'CCIR_00754' 'CCIR_00559'}
            mlraichle.TracerDirector2.constructResolvedStudy(varargin{:})
            
        case 'CCIR_00993'
            mlan.TracerDirector2.constructResolvedStudy(varargin{:})
            
        case 'subjects'
            if length(ss) > 1 && lstrfind(ss{2}, 'sub')
                if length(ss) > 2 && lstrfind(ss{3}, 'ses')
                    mlraichle.TracerDirector2.constructSessionsStudy(varargin{:})
                    return
                end
                mlraichle.TracerDirector2.constructSubjectsStudy(varargin{:})
                return
            end
            warning('mfiles:RuntimeWarning', 'construct_resolved:  nothing to do')
            
        case 'subjects_00993'            
            mlan.TracerDirector2.constructSessionsStudy(varargin{:})
            
        otherwise
            error('mfiles:RuntimeError', 'construct_resolved.ss{1}->%s', ss{1})
    end  
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

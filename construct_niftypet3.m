function construct_niftypet3(varargin)
    %% CONSTRUCT_NIFTYPET3 supports niftypet with python3 and t4_resolve.  
    %  It is the top level of a Matlab Compiler Runtime project.
    %  Usage:  construct_resolved(<folders experssion>)
    %          e.g.:  >> construct_resolved('CCIR_00123/ses-E00123/OO_DT20190101.000000-Converted-NAC')    
    %          e.g.:  >> construct_resolved('CCIR_00123/ses-E0012*/OO_DT*-Converted-NAC')
    %          e.g.:  >> construct_resolved('/home/usr/jjlee/Singularity/CCIR_00123/ses-E0012*/OO_DT*-Converted-NAC')
    %  
    %  @precondition fullfile(projectsDir, project, session, 'umapSynth_op_T1001_b43.4dfp.*').
    %  @precondition files{.bf,.dcm} in fullfile(projectsDir, project, session, 'LM', '').
    %  @precondition files{.bf,.dcm} in fullfile(projectsDir, project, session, 'norm', '').
    %  @precondition FreeSurfer recon-all results in fullfile(projectsDir, project, session, 'mri', '').
    %  @param foldersExpr is char.
    %  @return results in <folders experssion>.
    %
    %  N.B.:  Setting environment vars PROJECTS_DIR or SUBJECTS_DIR may not be compatible with Docker or Singularity
    %         use cases.    

    ss = strsplit(varargin{1}, filesep);

    if any(contains(ss, 'subjects_00993'))
        setenv('SUBJECTS_DIR', fullfile(getenv('PROJECTS_DIR'), 'subjects_00993'))
        if any(contains(ss, 'sub-'))
            if any(contains(ss, 'ses-'))
                mlan.TracerDirector2.constructSessionsStudy(varargin{:})
                return
            end
            mlan.TracerDirector2.constructSubjectsStudy(varargin{:})
            return
        end
        warning('mfiles:RuntimeWarning', 'construct_resolved:  nothing to do')
    end
    if any(contains(ss, 'subjects'))
        setenv('SUBJECTS_DIR', fullfile(getenv('PROJECTS_DIR'), 'subjects'))
        if any(contains(ss, 'sub-'))
            if any(contains(ss, 'ses-'))
                mlan.TracerDirector2.constructSessionsStudy(varargin{:})
                return
            end
            mlraichle.TracerDirector2.constructSubjectsStudy(varargin{:})
            return
        end
        warning('mfiles:RuntimeWarning', 'construct_resolved:  nothing to do')
    end

    proj = ss{contains(ss, 'CCIR_')};
    switch proj
        case {'CCIR_00754' 'CCIR_00559' 'CCIR_00559_00754'}
            mlraichle.TracerDirector2.constructResolvedStudy(varargin{:})
            
        case 'CCIR_00993'
            mlan.TracerDirector2.constructResolvedStudy(varargin{:})
        otherwise
            error('mfiles:RuntimeError', 'construct_resolved.ss->%s', ss)
    end  
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

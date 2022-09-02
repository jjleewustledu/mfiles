function construct_niftypet2(varargin)
    %% CONSTRUCT_NIFTYPET2 supports niftypet for python2 and t4_resolve.  
    %  It is the top level of a Matlab Compiler Runtime project.
    %  Usage:  construct_resolved(<folders experssion>)
    %          e.g.:  >> construct_niftypet2('CCIR_00123/ses-E00123/OO_DT20190101.000000-Converted-NAC')    
    %          e.g.:  >> construct_niftypet2('CCIR_00123/ses-E0012*/OO_DT*-Converted-NAC')
    %          e.g.:  >> construct_niftypet2('/home/usr/jjlee/Singularity/CCIR_00123/ses-E0012*/OO_DT*-Converted-NAC')
    %          e.g.:  >> construct_niftypet2('/data/anlab/jjlee/Singularity/CCIR_00993/derivatives/nipet/ses-E0012*')
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

    % subject-level constructions
    if any(contains(ss, 'resolve'))
        setenv('SUBJECTS_DIR', fullfile(getenv('SINGULARITY_HOME'), 'CCIR_00993/derivatives/resolve'))
        if any(contains(ss, 'sub-'))
            mlan.TracerDirector2.constructSubjectsStudy(varargin{:})
            return
        end
        warning('mfiles:RuntimeWarning', 'construct_niftypet2:  nothing to do')
    end

    % session-level constructions
    proj = ss{contains(ss, 'CCIR_')};
    switch proj
        case 'CCIR_00993'
            mlan.TracerDirector2.constructNiftypet2(varargin{:})
        otherwise
            error('mfiles:RuntimeError', 'construct_niftypet2.ss->%s', ss)
    end  
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

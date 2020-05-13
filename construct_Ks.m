function construct_Ks(varargin)
    %% CONSTRUCT_Ks supports mlpet.AerobicGlycolysisKit.  It is the top level of a Matlab Compiler Runtime project.
    %  Usage:  construct_resolved(<folders experssion>)
    %          e.g.:  >> construct_resolved('CCIR_00123/ses-E00123/OO_DT20190101.000000-Converted-NAC')    
    %          e.g.:  >> construct_resolved('CCIR_00123/ses-E0012*/OO_DT*-Converted-NAC')
    %  
    %  @precondition fullfile(projectsDir, project, session, 'umapSynth_op_T1001_b43.4dfp.*').
    %  @precondition files{.bf,.dcm} in fullfile(projectsDir, project, session, 'LM', '').
    %  @precondition files{.bf,.dcm} in fullfile(projectsDir, project, session, 'norm', '').
    %  @precondition FreeSurfer recon-all results in fullfile(projectsDir, project, session, 'mri', '').
    %  @param required foldersExpr is char.
    %  @param required cpuIndex is numeric.
    %  @param voxelTime is numeric/sec.
    %  @param wallClockLimit is numeric/sec.
    %  @param sessionsExpr is char.
    %  @param roisExpr in {'brain' 'brainmask' 'wmparc' ...}.
    %  @return results in <folders experssion>.
    %
    %  N.B.:  Setting environment vars PROJECTS_DIR or SUBJECTS_DIR may not be compatible with Docker or Singularity
    %         use cases.    

    ss = strsplit(varargin{1}, filesep);
    switch ss{1}
        case 'subjects'
            warning('off', 'mfiles:ChildProcessError')
            warning('off', 'MATLAB:cellRefFromNonCell')
            setenv('SUBJECTS_DIR', fullfile(getenv('PROJECTS_DIR'), 'subjects'))
            if length(ss) > 1 && lstrfind(ss{2}, 'sub')
                mlraichle.AerobicGlycolysisKit.constructSubjectsStudy(varargin{:})
                return
            end
            warning('mfiles:RuntimeWarning', 'construct_resolved:  nothing to do')
        otherwise
            error('mfiles:RuntimeError', 'construct_resolved.ss{1}->%s', ss{1})
    end  
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

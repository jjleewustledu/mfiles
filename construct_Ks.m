function construct_Ks(varargin)
    %% CONSTRUCT_Ks supports mlpet.AerobicGlycolysisKit.  It is the top level of a Matlab Compiler Runtime project.
    %  Usage:  construct_Ks(<folders expression>, <cpu>, 'sessionsExpr', <session expression>[, 'assemble', <T/F>])
    %          e.g.:  >> construct_Ks('subjects/sub-S58163', 1, 'sessionsExpr', 'ses-E03056')
    %          e.g.:  >> construct_Ks('subjects/sub-S58163', 1, 'sessionsExpr', 'ses-E03056', 'assemble', 1)
    %  
    %  @param required foldersExpr is char, e.g., 'subjects/sub-S58163'.
    %  @param required cpuIndex is numeric.
    %  @param voxelTime is numeric/sec.
    %  @param wallClockLimit is numeric/sec.
    %  @param sessionsExpr is char, e.g., 'ses-E03056'.
    %  @param roisExpr in {'brain' 'brainmask' 'wmparc' ...}.
    %  @return results in <folders experssion>.
    %
    %  N.B.:  Setting environment vars PROJECTS_DIR or SUBJECTS_DIR may not be compatible with Docker or Singularity
    %         use cases.    

    tic
    ss = strsplit(varargin{1}, filesep);
    switch ss{1}
        case 'subjects'
            warning('off', 'mfiles:ChildProcessError')
            warning('off', 'MATLAB:cellRefFromNonCell')
            setenv('SUBJECTS_DIR', fullfile(getenv('PROJECTS_DIR'), 'subjects'))
            if length(ss) > 1 && lstrfind(ss{2}, 'sub')
                mlraichle.AerobicGlycolysisKit.constructKsByVoxels(varargin{:})
                return
            end
            warning('mfiles:RuntimeWarning', 'construct_resolved:  nothing to do')
        otherwise
            error('mfiles:RuntimeError', 'construct_resolved.ss{1}->%s', ss{1})
    end
    toc
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

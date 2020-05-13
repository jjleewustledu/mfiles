function construct_Cbv(varargin)
    %% CONSTRUCT_CBV 
    %  Usage:  construct_Cbv(<folders experssion>)
    %          e.g.:  >> construct_resolved('subject/sub-S12345')    
    %  @param foldersExpr is char.
    %
    %  N.B.:  Setting environment vars PROJECTS_DIR or SUBJECTS_DIR may not be compatible with Docker or Singularity
    %         use cases.    

    ss = strsplit(varargin{1}, filesep);
    switch ss{1}
        case 'subjects'
            warning('off', 'mfiles:ChildProcessError')
            warning('off', 'MATLAB:cellRefFromNonCell')
            setenv('PROJECTS_DIR', getenv('SINGULARITY_HOME'))
            setenv('SUBJECTS_DIR', fullfile(getenv('PROJECTS_DIR'), 'subjects'))
                
            pwd0 = pushd(fullfile(getenv('PROJECTS_DIR'), ss{1}, ss{2})); % $SINGULARITY_HOME/subjects/sub-S00000
            for ses = globFoldersT('ses-E*/OC_DT*.000000-Converted-AC') 
                if isfolder(fullfile(getenv('PROJECTS_DIR'), 'CCIR_00559', ses{1}))
                    sesd = mlraichle.SessionData.create(fullfile('CCIR_00559', ses{1}));
                    kit = mlraichle.AerobicGlycolysisKit.createFromSession(sesd);
                    kit.buildCbv( ...
                        'filesExpr', fullfile('subjects', ss{2}, 'resampling_restricted', session_to_4dfp_hdr(ses{1})), ...
                        'averageVoxels', false)
                elseif isfolder(fullfile(getenv('PROJECTS_DIR'), 'CCIR_00754', ses{1}))
                    sesd = mlraichle.SessionData.create(fullfile('CCIR_00754', ses{1}));
                    kit = mlraichle.AerobicGlycolysisKit.createFromSession(sesd);
                    kit.buildCbv( ...
                        'filesExpr', fullfile('subjects', ss{2}, 'resampling_restricted', session_to_4dfp_hdr(ses{1})), ...
                        'averageVoxels', false)                    
                end                
            end
            popd(pwd0)
        otherwise
            error('mfiles:RuntimeError', 'construct_resolved.ss{1}->%s', ss{1})
    end  
    
    function fdfp = session_to_4dfp_hdr(ses)
        sp = split(ses, filesep);
        re = regexp(lower(sp{2}), '(?<tracer>[a-z]+)_dt(?<dt>\d{14})\.000000-converted-ac', 'names');
        fdfp = sprintf('%sdt%s_on_T1001.4dfp.hdr', re.tracer, re.dt);
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

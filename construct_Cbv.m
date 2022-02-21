function construct_Cbv(varargin)
    %% CONSTRUCT_CBV 
    %  Usage:  construct_Cbv(<folders experssion>)
    %          e.g.:  >> construct_resolved('subjects/sub-S12345')    
    %  @param foldersExpr is char.
    %
    %  N.B.:  Setting environment vars PROJECTS_DIR or SUBJECTS_DIR may not be compatible with Docker or Singularity
    %         use cases.    

    ss = strsplit(varargin{1}, filesep);
    switch ss{1}
        case 'subjects'
            setenv('PROJECTS_DIR', getenv('SINGULARITY_HOME'))
            setenv('SUBJECTS_DIR', fullfile(getenv('PROJECTS_DIR'), 'subjects'))
                
            pwd0 = pushd(fullfile(getenv('PROJECTS_DIR'), ss{1}, ss{2})); % $SINGULARITY_HOME/subjects/sub-S00000
            for ses = globFoldersT('ses-E*')
                
                brainOnAtlas = fullfile(pwd, 'resampling_restricted', 'brain_222.4dfp.hdr');
                mlnipet.ResolvingSessionData.jitOn111(brainOnAtlas)
                ocSignalAveraged = mlfourd.ImagingFormatContext(brainOnAtlas);
                ocSignalAveraged.img = zeros(size(ocSignalAveraged));
                ocCount = 0;
                sesd = [];
                
                for tracer = globFoldersT(fullfile(ses{1}, 'OC_DT*.000000-Converted-AC')) 
                    tracerOnAtlas = '';
                    if isfolder(fullfile(getenv('PROJECTS_DIR'), 'CCIR_00559', tracer{1}))
                        sesd = mlraichle.SessionData.create(fullfile('CCIR_00559', tracer{1}));
                        tracerOnAtlas = sesd.tracerOnAtlas('typ', 'filename');
                    elseif isfolder(fullfile(getenv('PROJECTS_DIR'), 'CCIR_00754', tracer{1}))
                        sesd = mlraichle.SessionData.create(fullfile('CCIR_00754', tracer{1}));
                        tracerOnAtlas = sesd.tracerOnAtlas('typ', 'filename');
                    end  
                    if ~isempty(tracerOnAtlas)
                        try
                            kit = mlraichle.AerobicGlycolysisKit.createFromSession(sesd);
                            cbv = kit.buildCbv( ...
                                'filesExpr', fullfile('subjects', ss{2}, 'resampling_restricted', tracerOnAtlas), ...
                                'averageVoxels', false);
                            
                            if ~dipisnan(cbv)
                                ocSignalAveraged.img = ocSignalAveraged.img + cbv.fourdfp.img;
                                ocCount = ocCount + 1;
                            end
                        catch ME
                            handwarning(ME)
                        end
                    end
                end
                
                if ~isempty(sesd)
                    ocSignalAveraged.img = ocSignalAveraged.img/ocCount;
                    ocSignalAveraged.fileprefix = sesd.cbvOnAtlas('typ', 'fileprefix', 'dateonly', true);
                    ocSignalAveraged.save()
                end
            end
            popd(pwd0)
        otherwise
            error('mfiles:RuntimeError', 'construct_resolved.ss{1}->%s', ss{1})
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  

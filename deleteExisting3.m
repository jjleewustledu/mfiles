function deleteExisting3(varargin)
    try
        dt = mlsystem.DirTools(varargin{:});
        for d = 1:length(dt.fqfns)
            delete(      dt.fqfns{d});
            delete(logfn(dt.fqfns{d}));
        end
        for d = 1:length(dt.fqdns)
            [~,m,id] = rmdir(dt.fqdns{d}, 's');
        end
    catch ME
        handexcept(ME, id, m);
    end

    function fn_ = logfn(fn_)
        [p,f,~] = myfileparts(fn_);
        fn_ = fullfile(p, [f '.log']);
    end
end


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/deleteExisting.m] ======  

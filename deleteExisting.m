function deleteExisting(obj)

    if (isempty(obj))
        return
    end
    
    % recursion for cell, mlfourd.INIfTI
    if (iscell(obj))
        cellfun(@(x) deleteExisting(x), obj, 'UniformOutput', false);
        return
    end
    if (isa(obj, 'mlfourd.INIfTI'))
        deleteExisting(obj.fqfilename);
        return
    end
    
    assert(ischar(obj));   
    
    % recursion for wild '*', '.4dfp'
    if (lstrfind(obj, '*'))
        dt = mlsystem.DirTool(obj);
        if (dt.length < 1); return; end
        deleteExisting(dt.fqfns);
        return
    end
    
    % base case
    try
        if (lexist(obj))
            delete(obj);
        end
        lgfn = logfn(obj);
        if (lexist(lgfn))
            delete(lgfn);
        end
    catch ME
        dispexcept(ME);
    end
    function fn_ = logfn(fn_)
        [p,f,~] = myfileparts(fn_);
        fn_ = fullfile(p, [f '.log']);
    end
end



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/deleteExisting.m] ======  

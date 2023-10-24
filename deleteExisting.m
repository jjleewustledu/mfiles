function deleteExisting(obj, varargin)
%% DELETEEXISTING supports Matlab delete for wild cards of glob.  
%  It also supports cell arrays, mlfourd.INIfTI, mlfourd.HandleINIfTI.
%  @param required obj to delete, e.g. obj_file.nii.gz.
%  @param log is char extension of log files to also delete, e.g., delete obj_file.log and obj_file.nii.gz.
%  @param metadata is char extension of metadata files to also delete, e.g., delete obj_file.json and obj_file.nii.gz.
%
%  Copyright 2019 John J. Lee.

    ip = inputParser;
    addParameter(ip, 'log', '.log', @istext)
    addParameter(ip, 'metadata', '.json', @istext)
    parse(ip, varargin{:})  
    ipr = ip.Results;
    if (isempty(obj))
        return
    end
    obj = convertStringsToChars(obj);
    obj = convertStringsToChars(obj);
    
    %% recursions for objects
    
    if (iscell(obj))
        cellfun(@(x) deleteExisting(x, 'log', ipr.log, 'metadata', ipr.metadata), obj, 'UniformOutput', false);
        return
    end
    if (isa(obj, 'mlfourd.INIfTI') || isa(obj, 'mlfourd.HandleINIfTI') || ...
        isa(obj, 'mlio.IOInterface'))
        deleteExisting(obj.fqfilename, 'log', ipr.log, 'metadata', ipr.metadata);
        return
    end
    
    %% base case
    
    assert(istext(obj));
    for g = asrow(glob(obj))
        if isempty(g)
            return
        end
        try
            lf = logfn(g{1}, ipr);
            if ~isempty(ipr.log) && isfile(lf)
                delete(lf);
            end
            mf = metadatafn(g{1}, ipr);
            if ~isempty(ipr.metadata) && isfile(mf)
                delete(mf);
            end
            if contains(g{1}, '.4dfp')                
                delete(strcat(myfileprefix(g{1}), '.4dfp.*'));
                return
            end
            if isfile(g{1})
                delete(g{1});
            end
        catch ME            
            handexcept(ME, 'mfiles:RuntimeError', 'deleteExisting(%s)', g{1})
        end
    end
    
    %% internal 
    
    function fn_ = logfn(fn_, ipr)
        [p,f] = myfileparts(fn_);
        fn_ = fullfile(p, [f ipr.log]);
    end
    function fn_ = metadatafn(fn_, ipr)
        [p,f] = myfileparts(fn_);
        fn_ = fullfile(p, [f ipr.metadata]);
    end
end



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/deleteExisting.m] ======  

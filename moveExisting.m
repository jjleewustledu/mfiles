function [s,m,mid] = moveExisting(obj, dest, varargin)
%% MOVEEXISTING supports Matlab movefile for wild cards of glob.  
%  It also supports cell arrays, mlfourd.INIfTI, mlfourd.HandleINIfTI.  movefile(_,_,'f') is not supported.
%  @param required obj to move, e.g. obj_file.nii.gz.
%  @param required dest is the destination location.
%  @param log is char extension of log files to also move, e.g., move obj_file.log and obj_file.nii.gz.
%  @param metadata is char extension of metadata files to also move, e.g., move obj_file.json and obj_file.nii.gz.
%  @returns objects returned by movefile, possibly wrapped in cell array.
%
%  Copyright 2023 John J. Lee.

    ip = inputParser;
    addParameter(ip, 'log', '.log', @istext)
    addParameter(ip, 'metadata', '.json', @istext)
    parse(ip, varargin{:})  
    ipr = ip.Results;
    if (isempty(obj))
        return
    end
    if (isempty(dest))
        return
    end
    
    %% recursions for objects
    
    if (iscell(obj))
        [s,m,mid] = cellfun(@(x) moveExisting(x, dest, 'log', ipr.log, 'metadata', ipr.metadata), obj, 'UniformOutput', false);
        return
    end
    if (isa(obj, 'mlfourd.INIfTI') || isa(obj, 'mlfourd.HandleINIfTI') || ...
        isa(obj, 'mlio.IOInterface'))
        [s,m,mid] = moveExisting(obj.fqfilename, dest, 'log', ipr.log, 'metadata', ipr.metadata);
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
                [s,m,mid] = movefile(lf, dest);
            end
            mf = metadatafn(g{1}, ipr);
            if ~isempty(ipr.metadata) && isfile(mf)
                [s,m,mid] = movefile(mf, dest);
            end
            if contains(g{1}, '.4dfp')                
                [s,m,mid] = movefile(strcat(myfileprefix(g{1}), '.4dfp.*'), dest);
                return
            end
            if isfile(g{1})
                [s,m,mid] = movefile(g{1}, dest);
            end
        catch ME            
            handexcept(ME, 'mfiles:RuntimeError', 'moveExisting(%s)', g{1})
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
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/moveExisting.m] ======  

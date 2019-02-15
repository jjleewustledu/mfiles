function obj = ensureSafenameMgz(obj)
%% ENSURESAFENAMEMGZ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2018 John Joowon Lee. 

    UNSAFE_FILEPREFIXES = {'_on_' '+' '.a2009s'}; % '_op_' removed 2018feb8        
        
    if (isempty(obj))
        return
    end
    if (iscell(obj))
        obj = cellfun(@(x) ensureSafenameMgz(x), obj,  'UniformOutput', false);
        return
    end
    if (isa(obj, 'mlio.IOInterface') || isa(obj, 'mlio.HandleIOInterface'))
        obj.fileprefix = ensureSafenameMgz(obj.fileprefix);
        return
    end
    if (ischar(obj))
        [pth,fp,x] = myfileparts(obj);
        fn = [fp x];
        unsafe = UNSAFE_FILEPREFIXES;
        for u = 1:length(unsafe)
            if (lstrfind(fn, unsafe{u}))
                idxs = regexp(fn, unsafe{u});
                while (~isempty(idxs))                            
                    fn = safesprintf(unsafe{u}, fn, idxs);
                    idxs = regexp(fn, unsafe{u});
                end
            end
        end
        obj0 = obj;
        obj = fullfile(pth, fn);
        if (lexist(obj0, 'file') && ~lexist(obj, 'file'))
            copyfile(obj0, obj);
        end
        return
    end
    error('mfiles:unsupportedTypeclass', 'ensureSafenameMgz');    

    function s = safesprintf(unsafeStr, fp, idxs)
        idx1 = idxs(1);
        idx2 = idx1;
        try
            switch (unsafeStr)
                case '_on_'
                    idx2 = idx1+4;
                    s = sprintf('%sOn%s%s', fp(1:idx1-1), upper(fp(idx2)), fp(idx2+1:end));
                case '_op_'
                    idx2 = idx1+4;
                    s = sprintf('%sOp%s%s', fp(1:idx1-1), upper(fp(idx2)), fp(idx2+1:end));
                case '+'
                    idx2 = idx1+1;
                    s = sprintf('%s%s%s', fp(1:idx1-1), upper(fp(idx2)), fp(idx2+1:end));
                case '.a2009s'
                    idx2 = idx1+1;
                    s = sprintf('%s%s%s', fp(1:idx1-1), upper(fp(idx2)), fp(idx2+1:end));
                otherwise
                    error('mlfourdfp:unsupportedSwitchcase', 'FourdfpVisitor.safesprintf.fp->%s', fp)
            end
        catch ME
            assert(idx1 > 1, ...
                'FourdfpVisitor.safesprintf.fp->%s may be missing prefix', fp);
            assert(length(fp) >= idx2, ...
                'FourdfpVisitor.safesprintf.fp->%s may be missing suffix', fp);
            handexcept(ME);
        end
    end

end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/ensureSafenameMgz.m] ======  

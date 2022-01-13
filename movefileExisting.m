function movefileExisting(varargin)
%% MOVEFILEEXISTING ... 
%  @param source is cell | mlfourd.ImagingContext | char; '*' is recognized.
%  @param optional dest is dir.
%  @return never invokes movefile -f.
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.2.0.538062 (R2017a).  Copyright 2017 John Joowon Lee. 

    ip = inputParser;
    addRequired(ip, 'source', @(x) iscell(x) | isa(x, 'mlfourd.ImagingContext') | ischar(x));
    addOptional(ip, 'dest', '.', @isfolder);
    parse(ip, varargin{:});
    src = ip.Results.source;
    dst = ip.Results.dest;

    if (isempty(src))
        return
    end
    if (iscell(src))
        cellfun(@(x) movefileExisting(x, varargin{2:end}), src, 'UniformOutput', false);
        return
    end
    if (isa(src, 'mlfourd.ImagingContext'))
        movefileExisting(src.fqfilename, varargin{2:end});
        return
    end
    
    assert(ischar(src));
    
    if (lstrfind(src, '*'))
        dt = mlsystem.DirTool(src);
        if (dt.length < 1); return; end
        movefileExisting(dt.fqfns, dst);
        return
    end
    try
        if (lexist(src))
            movefile(src, dst);
        end
        lgfn = logfn(src);
        if (lexist(lgfn))
            movefile(lgfn, dst);
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
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/movefileExisting.m] ======  

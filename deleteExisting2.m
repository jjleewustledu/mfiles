function deleteExisting2(varargin)
    try
        dt = mlsystem.DirTool(varargin{:});
        for d = 1:length(dt.fqfns)
            delete(dt.fqfns{d});
        end
        for d = 1:length(dt.fqdns)
            [~,m,id] = rmdir(dt.fqdns{d}, 's');
        end
    catch ME
        handexcept(ME, id, m);
    end
end


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/deleteExisting.m] ======  

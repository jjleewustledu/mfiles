function ca = expandPaths(pths)
%% EXPANDPATHS ... 
%   
%  Usage:  cellarray = expandPaths(paths) 
%          ^ cell-vector           ^ string, structs, struct-array, cell-vector of
%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/expandPaths.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

    if (iscell(pths))
        ca = expandCells(pths);
    else
        if (isstruct(pths))
            if (length(pths) > 1)
                ca = expandStructs(pths);
            else
                if (pths.isdir)
                    ca = expandPaths(pths.name);
                else
                    ca = {};
                end
            end
        elseif (ischar(pths))
            
            dt = mlsystem.DirTool(pths);
            if (isempty(dt.fqdns))
                ca = {pths};
            else
                ca = dt.fqdns;
            end
        else
            error('mfiles:UnsupportedType', 'class(expandPaths.pths)->%s', class(pths));
        end
    end

    function ca = expandCells(pths)        
        ca = cell(size(pths));
        for p = 1:length(pths)
            ca{p} = expandPaths(pths{p});
        end
    end % expandCellsl

    function ca = expandStructs(pths)
        ca = cell(size(pths));
        for p = 1:length(pths)
            ca{p} = expandPaths(pths(p));
        end
    end % expandStructs
end % expandPaths








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/expandPaths.m] ======  

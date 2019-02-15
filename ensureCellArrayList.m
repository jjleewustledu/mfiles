function cal = ensureCellArrayList(varargin)
    %% ENSURECELLARRAYLIST ... 
    %   
    %  Usage:  cell-array-list = ensureCellArrayList(obj[, obj2, ..., ...]) 
    %           
    %% Version $Revision: 2369 $ was created $Date: 2013-03-05 06:40:54 -0600 (Tue, 05 Mar 2013) $ by $Author: jjlee $,  
    %% last modified $LastChangedDate: 2013-03-05 06:40:54 -0600 (Tue, 05 Mar 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/ensureCellArrayList.m $ 
    %% Developed on Matlab 8.0.0.783 (R2012b) 
    %% $Id$ 

    cal = mlpatterns.CellArrayList;
    for v = 1:length(varargin)
        cal.add(chgtype(varargin{v}));
    end
    cal = cellArrayListCopy(cal);

    function obj = chgtype(obj)
        if (isa(obj, 'mlpatterns.CellArrayList'))
            obj = cal2cell(obj); return; end
        if (isstruct(obj) && length(obj) > 1)
            obj = structs2cell(obj); return; end
        if (isa(obj, 'mlpatterns.HandlelessListInterface') && length(obj) > 1)
            obj = hli2cell(obj); return; end
    end
    function cll = cal2cell(cal)
        cll = cell(1, length(cal));
        for c = 1:length(cal)
            cll{c} = cal.get(c);
        end
    end
    function cll = structs2cell(str)
        cll = cell(1, length(str));
        for c = 1:length(str)
            cll{c} = str(c);
        end
    end
    function cll = hli2cell(hli)
        cll = cell(1, length(hli));
        for c = 1:length(hli)
            cll{c} = hli.get(c);
        end
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureCellArrayList.m] ======  

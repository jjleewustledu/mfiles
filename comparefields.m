function summary = comparefields(obj, obj2)
%% COMPAREFIELDS of structs or classes or cell-arrays of
%   
%  Usage:  summary_string = comparefields(obj, obj_to_compare) 
%                                         
%% Version $Revision: 2473 $ was created $Date: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/comparefields.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

    FIELD_OFFSET = 2;
    if (iscell(obj))
        summary = comparecells(obj, obj2); 
        return
    end
    assertfieldnames(obj, obj2);
    summary = '';
    flds = fieldnames(obj);
    for f = (1 + FIELD_OFFSET):length(flds)
        try %#ok<*TRYNC>
            if (~strcmp(obj.(flds{f}), obj2.(flds{f})))
                summary = sprintf('%s %s: %s, %s; ', summary, flds{f}, obj.(flds{f}), obj2(flds{f}));
            end
        end
    end

    function summry = comparecells(cll, cll2)
        assertcells(cll, cll2);
        summry = '';
        for c = 1:length(cll)
            try
                summry = sprintf('%s\n%i-th cell:  %s', summry, c, comparefields(cll{c}, cll2{c}));
            end
        end
        summry = sprintf('%s\n\n', summry);
    end
    function assertcells(cll, cll2)
        assert(iscell(cll));
        assert(iscell(cll2));
        assert(length(cll) == length(cll2));
    end
    function assertfieldnames(ob, ob2)
        all(strcmp(fieldnames(ob), fieldnames(ob2)));
    end
end





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/comparefieldnames.m] ======  

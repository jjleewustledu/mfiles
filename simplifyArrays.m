function arr = simplifyArrays(arr)
%% SIMPLIFYARRAYS returns the typeclass of the array contents if the array has unit-length
%  Usage:  simpler_object = simplifyArrays(array_object) 

%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/simplifyArrays.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 

if (1 == length(arr))
    switch (class(arr))
        case 'cell'
            arr = arr{1};
        case 'struct'
            arr = arr(1);
        otherwise
            if (isa(arr, 'mlpatterns.ValueList'))
                arr = arr.get(1);
            else
                error('mfile:unsupportedType', 'class(simplifyArrays.arr) -> %s', class(arr));
            end
    end
end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/simplifyArrays.m] ======  

function idx = findindex(arr, tofind)
%% FINDINDEX    
%  Usage:  index = findindex(array, to_find) 
%          ^ vec of indices of array containing to_find
%                            ^ cell or numeric array, must be vector
%                                   ^ string or number to find
%
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/findindex.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

if (ischar(arr)); arr = {arr}; end

assert(isvector(arr));
assert(~isempty(arr));
switch (class(arr))
    case numeric_types
        switch (class(tofind))
            case numeric_types                
                arr = (arr == tofind);
            case 'char'
                tofind = str2double(tofind);
                arr = (arr == tofind);
            otherwise
                error('mfiles:UnsuportedType', 'class(findindex.tofind)->%s', class(tofind));
        end
    case 'cell'
        switch (class(arr{1}))
            case numeric_types
                switch (class(tofind))
                    case numeric_types  
                        arr = cell2mat(arr);
                        arr = (arr == tofind);
                    case 'char'
                        tofind = str2double(tofind);                        
                        arr = (arr == tofind);
                    otherwise
                        error('mfiles:UnsuportedType', 'class(findindex.tofind)->%s', class(tofind));
                end
            case 'char'
                switch (class(tofind))
                    case numeric_types 
                        tofind = num2str(tofind);
                        arr = strncmp(tofind, arr, length(tofind));
                    case 'char'
                        arr = strncmp(tofind, arr, length(tofind));
                    otherwise
                        error('mfiles:UnsuportedType', 'class(findindex.tofind)->%s', class(tofind));
                end
            otherwise
                error('mfiles:UnsuportedType', 'class(findindex.arr{1})->%s', class(arr{1}));
        end
    otherwise
        error('mfiles:UnsuportedType', 'class(findindex.arr)->%s', class(arr));
end

idx = [];
for a = 1:length(arr)
    if (arr(a)); idx = [idx a]; end
end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/findindex.m] ======  

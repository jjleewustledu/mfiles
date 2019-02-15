function cal = cellArrayListAdd(cal, elts, varargin)
%% CELLARRAYLISTADD extends mlpatterns.CellArrayList.add to safetly add more cell-array lists.
%   
%  Usage:  cal = cellArrayListAdd(cal, elementsToAdd[, locationForAdd]) 
%          ^ cell-array list
%
%% Version $Revision: 2583 $ was created $Date: 2013-08-29 02:58:59 -0500 (Thu, 29 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-29 02:58:59 -0500 (Thu, 29 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/cellArrayListAdd.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

import mlfourd.*;
narginchk(2,3);
assert(isa(cal, 'mlpatterns.CellArrayList'));
assert(~isempty(elts));
switch (class(elts))
    case 'cell'
        for e = 1:length(elts)
            cal = cellArrayListAdd(cal, elts{e}, varargin{:});
        end
    case 'mlpatterns.CellArrayList'
        for e = 1:length(elts)
            cal = cellArrayListAdd(cal, elts.get(e), varargin{:});
        end
    otherwise
        cal.add(elts, varargin{:});
end


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/cellArrayListAdd.m] ======  

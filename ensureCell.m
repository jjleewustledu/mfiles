function obj = ensureCell(obj)
%% ENSURECELL 
%  Usage:  obj = ensureCell(obj) 
%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/ensureCell.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

if (isa(obj, 'mlfourd.ImagingArrayList'))
    obj2 = cell(1,obj.length);
    iter = obj.createIterator;
    idx  = 1;
    while (iter.hasNext)
        obj2{idx} = iter.next;
             idx = idx + 1;
    end
    obj = obj2;
end
if (~iscell(obj))
    obj = {obj};
end









% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureCell.m] ======  

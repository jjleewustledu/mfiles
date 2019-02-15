function cal = cellArrayListCopy(cal0)
%% CELLARRAYLISTCOPY returns a deep copy of a cell-array list
%   
%  Usage:  cell_array_list_copy = cellArrayListCopy(cell_array_list) 
%          
%% Version $Revision: 2282 $ was created $Date: 2012-09-30 01:00:51 -0500 (Sun, 30 Sep 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-09-30 01:00:51 -0500 (Sun, 30 Sep 2012) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/cellArrayListCopy.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$

cal = mlpatterns.CellArrayList;
cal = cellArrayListAdd(cal, cal0);


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/cellArrayListCopy.m] ======  

function tf = isemptyValueList(hl)
%% ISEMPTYVALUELIST throws exceptions for unexpected typeclasses 
%   
%  Usage:  boolean = isemptyValueList(mlpatterns.ValueList_object) 
%          ^ 
%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/isemptyValueList.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

if (~isa(hl, 'mlpatterns.ValueList'))
    error('mfiles:UnsupportedTypeclass', 'isemptyValueList.cal->%s', class(hl)); end
tf = isempty(hl);








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/isemptyValueList.m] ======  

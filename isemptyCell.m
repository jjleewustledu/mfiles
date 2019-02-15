function tf = isemptyCell(c)
%% ISEMPTYCELL throws an exception if typeclass is unexpected
%   
%  Usage:  boolean = isemptyCell(cell-array) 

%% Version $Revision: 2473 $ was created $Date: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/isemptyCell.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

if (~iscell(c))
    error('mfiles:unexpectedTypeclass', 'isemptyCell.s->%s', class(c)); end
tf = isempty(c);







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/isemptyCell.m] ======  

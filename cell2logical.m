function tf = cell2logical(incell)
%% CELL2LOGICAL is for the idiom:  cellarray(cell2logical(strfind(charcells, chartarget)))
%  Usage:  logical_array = cell2logical(cell_logical) 
%          ^ 
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/cell2logical.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

assert(iscell(incell));
tf = cellfun(@(x) ~isempty(x), incell, 'UniformOutput', false);
tf = cell2mat(tf);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/cell2logical.m] ======  

function tf = iscellEmpty(c)
%% ISCELLEMPTY ... 
%   
%  Usage:  iscellEmpty() 
%          ^ 
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/iscellEmpty.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

tf = iscell(c) && isempty(c);







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/iscellEmpty.m] ======  

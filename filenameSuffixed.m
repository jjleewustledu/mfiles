function fn = filenameSuffixed(imobj, suffix)
%% FILENAMESUFFIXED ... 
%   
%  Usage:  filenameSuffixed() 
%          ^ 
%% Version $Revision: 2551 $ was created $Date: 2013-08-22 04:37:16 -0500 (Thu, 22 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-22 04:37:16 -0500 (Thu, 22 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/filenameSuffixed.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 

fn = filename( ...
    [imcast(imobj, 'fileprefix') suffix]);








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/filenameSuffixed.m] ======  

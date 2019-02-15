function tf = isImagingComponentEmpty(imcmp)
%% ISIMAGINGCOMPONENTEMPTY ... 
%   
%  Usage:  isImagingComponentEmpty() 
%          ^ 
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/isImagingComponentEmpty.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

tf = isa(imcmp, 'mlfourd.ImagingComponent') && isempty(imcmp);





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/isstructEmpty.m] ======  

function [vecL,vecR,maskL,maskR] = splitLandR(vec, indices)
%% SPLITLANDR removes zeros and nans from vecs so that they create a nicer plot
%   
%  Usage:  vecs = stripzeros(vecs) 
%          ^ 
%% Version $Revision: 2473 $ was created $Date: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/splitLandR.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

assert(length(vec) == length(indices));
assert(all(isfinite(vec)));
assert(all(isfinite(indices)));

maskL = (indices > 255) & (indices < 12000);
maskR =  indices > 12000;
vecL  = vec(maskL);

vecR  = vec(maskR);







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/stripzeros.m] ======  

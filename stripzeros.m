function [vec,vec2] = stripzeros(vec, vec2)
%% STRIPZEROS removes zeros and nans from vecs so that they create a nicer plot
%   
%  Usage:  vecs = stripzeros(vecs) 
%          ^ 
%% Version $Revision: 2473 $ was created $Date: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/stripzeros.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

assert(length(vec) == length(vec2));
okies  = abs(vec)  > eps & isfinite(vec);
okies2 = abs(vec2) > eps & isfinite(vec);
okies  = okies & okies2;
vec    = vec(okies);
vec2   = vec2(okies);






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/stripzeros.m] ======  

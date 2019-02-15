function [vec2,okies] = stripunused(vec, unused)
%% STRIPUNUSED removes unused indices from vec so that they are easier to plot; also strips out zeros and nans
%   
%  Usage:  vec = stripunused(vec, unused) 
%          ^                 ^    ^ double

%% Version $Revision: 2473 $ was created $Date: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/stripunused.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

THRESH = 0.05;
ordinals = [];
jj = 1;
for ii = 1:length(vec)
    if (~any(unused == ii))
        ordinals(jj) = ii; %#ok<AGROW>
        jj = jj + 1;
    end 
end

vec2 = vec(ordinals);
okies = abs(vec2/mean(vec2)) > THRESH & isfinite(vec2);
vec2 = vec2(okies);




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/stripzeros.m] ======  

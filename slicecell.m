function cout = slicecell(carr, idx)
%% SLICECELL returns the requested subset of the passed multi-dim cell-array
%   
%  Usage:  subcell = slicecell(incell, idx) 
%          ^ size -> [idx size(incell,2)]
%                                      ^ int
%% Version $Revision: 1220 $ was created $Date: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/slicecell.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 

szarr = size(carr);
assert( size(carr,1) > 1);

cout  = cell(1,szarr(2));
for c = 1:szarr(2)
    cout{c} = carr{idx,c};
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/slicecell.m] ======  

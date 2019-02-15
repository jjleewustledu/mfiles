function cav = flattencell(cat)
%% FLATTENCELL flattens a cell-array tree into a cell-array vector
%  Usage:  cav = flattencell(cat)  
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/flattencell.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

cav = {};
for t = 1:length(cat)
    if (iscell(cat{t}))
        cav = [cav flattencell(cat{t})]; %#ok<*AGROW>
    else
        cav = [cav cat{t}];
    end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/flattencell.m] ======  

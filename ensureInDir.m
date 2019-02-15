function loc = ensureInDir(loc, fqdir)
%% ENSUREINDIR ... 
%  Usage:  location = ensureInDir(location, fully_qualified_dir) 

%% Version $Revision: 2636 $ was created $Date: 2013-09-16 01:20:51 -0500 (Mon, 16 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-16 01:20:51 -0500 (Mon, 16 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/ensureInDir.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

idx = strfind(loc, fqdir);
if (isempty(idx))
    loc = fullfile(fqdir, loc);
    return
end

assert(length(idx) < 2);
if (1 == idx)
    return; end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureInDir.m] ======  

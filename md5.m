function digest = md5(fn)
%% MD5 ... 
%   
%  Usage:  digest = md5(fully-qualified-filename) 
%          ^string 
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/md5.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

DIGEST_EXP = 'MD5 (\S+) = (?<digest>\w+)';

[s,r] = mlbash(sprintf('md5 %s', fn));
assert(0 == s);
names = regexp(r, DIGEST_EXP, 'names');
digest = names.digest;







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/md5.m] ======  

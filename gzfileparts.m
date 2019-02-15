function [fpath, fprefix, fsuffix] = gzfileparts(str)
%% GZFILEPARTS extends fileparts to always regard .suffix.gz as a single file extension

%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/gzfileparts.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

assert(ischar(str));
[fpath,s2,s3] = fileparts(str);
if (strcmp('.gz', s3))
    [~,fprefix,s4] = fileparts(s2); 
    fsuffix = [s4 s3];
else
    fprefix = s2;
    fsuffix = s3;
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/gzfileparts.m] ======  

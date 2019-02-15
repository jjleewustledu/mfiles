function [p,f,e] = niftiparts(fqfn)
%% NIFTIPARTS is fileparts that understands .nii.gz and ignores .4dfp
%   
%  Usage:  [path, fileprefix, extension] = niftiparts(fqfn)  
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/niftiparts.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

[p,f,e] = fileparts(fqfn);
if (lstrfind(f, '.nii'))
    [~,f,e2] = fileparts(f); 
    e        = [e2 e];
end
if (lstrfind(f, '.4dfp')) 
    f = strtok(f, '.4');
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/niftiparts.m] ======  

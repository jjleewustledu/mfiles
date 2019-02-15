function fn = matrixfile(fn)
%% MATRIXFILE ensures that provided filenaem has a format acceptable to FSL
%   
%  Usage:  fn = matrixfile(fn) 
%          ^ ensured to end in mlfsl.FlirtVisitor.XFM_SUFFIX
%% Version $Revision: 2306 $ was created $Date: 2013-01-12 17:49:33 -0600 (Sat, 12 Jan 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-01-12 17:49:33 -0600 (Sat, 12 Jan 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/matrixfile.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

assert(ischar(fn));
fn = fileprefix(fn);
if (isempty(strfind(fn, mlfsl.FlirtVisitor.XFM_SUFFIX)))
    fn = [fn mlfsl.FlirtVisitor.XFM_SUFFIX];
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/matrixfile.m] ======  

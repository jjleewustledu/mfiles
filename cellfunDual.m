function out = cellfunDual(fun, arg)
%% CELLFUNDUAL ... 
%   
%  Usage:  out = cellfunDual(in, arg) 
%          ^                 ^ cell-arrays
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/cellfunDual.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

out = cell(fun);
for f = 1:length(fun)
    out{f} = fun{f}(arg);
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/cellfunDual.m] ======  

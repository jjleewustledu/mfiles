function mn = dipmin(arr, varargin)
%% DIPMIN
%  Usage:  mn = dipmin(arr[, ...]) 
%          ^ scalar
%  See also:  min
%% Version $Revision: 1220 $ was created $Date: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/dipmin.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 

arr = double(arr);
arr = reshape(arr, 1, []);
mn  = min(arr, varargin{:});

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/dipmin.m] ======  

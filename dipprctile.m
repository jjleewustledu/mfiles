function d = dipprctile(arr, pcnt, varargin)
%% DIPPRCTILE ... 
%  Usage:  d = dipprctile(arr, pcnt[, ...]) 
%          ^ scalar
%  See also:  prctile
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

arr = double(arr);
if (pcnt > 1); pcnt = pcnt/100; end
arr = reshape(arr, 1, []);
arr = arr(arr > min(arr));
d   = prctile(arr, 100*pcnt, varargin{:});

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/dipprctile.m] ======  

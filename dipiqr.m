function d = dipiqr(arr, varargin)
%% DIPIQR ... 
%  Usage:  d = dipiqr(arr[, ...]) 
%          ^ scalar
%  See also:  iqr
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

arr = double(arr);
arr = reshape(arr, 1, []);
d   = iqr(arr, varargin{:});






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/dipiqr.m] ======  

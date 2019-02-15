function tf = dipisnan(arr, varargin)
%% DIPISNAN finds any nans.
%  Usage:  tf = dipisnan(arr[, ...]) 
%          ^ scalar
%  See also:  isnan
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

arr = double(arr);
arr = reshape(arr, 1, []);
tf  = any(isnan(arr, varargin{:}));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/dipisnan.m] ======  

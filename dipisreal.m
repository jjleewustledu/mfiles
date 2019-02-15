function tf = dipisreal(arr, varargin)
%% DIPISREAL determines all real.
%  Usage:  tf = dipisreal(arr[, ...]) 
%          ^ scalar
%  See also:  isreal
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

arr = double(arr);
arr = reshape(arr, 1, []);
tf  = all(isreal(arr, varargin{:}));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/dipisreal.m] ======  

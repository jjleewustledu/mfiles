function d = dipquantile(arr, qnt, varargin)
%% DIPQUANTILE ... 
%  Usage:  d = dipquantile(arr, qnt[, ...]) 
%          ^ scalar
%  See also:  quantile
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

arr = double(arr);
if (qnt > 1); qnt = qnt/100; end
arr = reshape(arr, 1, []);
d   = quantile(arr, qnt, varargin{:});

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/dipquantile.m] ======  

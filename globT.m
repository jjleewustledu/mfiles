function [list,isdir] = globT(varargin)
%% GLOBT
%  Usage:  [list,isdir] = globT(<args to glob()>)
%  Args:  passed to glob().
%  Returns:
%      list cell:  row of globbed files and folders stripped of trailing filesep.
%      isdir logical:  row of trues for folders.
%
%% Version $Revision$ was created $Date$ by $Author$,
%% last modified $LastChangedDate$ and checked into repository $URL$,
%% developed on Matlab 9.7.0.1216025 (R2019b) Update 1.  Copyright 2019 John Joowon Lee.

[list,isdir] = glob(varargin{:});
list = list';
list = strip(list, 'right', filesep);
isdir = isdir';

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/globT.m] ======  

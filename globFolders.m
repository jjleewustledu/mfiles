function [list,isdir] = globFolders(varargin)
%% GLOBFOLDERS
%  Usage:  [list,isdir] = globFolders(<args to glob()>)
%  Args:  passed to glob().
%  Returns:
%      list cell:  col of globbed folders stripped of trailing filesep.
%      isdir logical:  col of all trues for folders, matching interface of glob().
%
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1216025 (R2019b) Update 1.  Copyright 2019 John Joowon Lee. 


[list,isdir] = glob(varargin{:});
list = list(isdir);
list = strip(list, 'right', filesep);
isdir = true(size(list));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/globFolders.m] ======  

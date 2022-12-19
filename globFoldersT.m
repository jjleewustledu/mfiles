function [list,isdir] = globFoldersT(varargin)
%% GLOBFOLDERST
%  Usage:  [list,isdir] = globFoldersT(<args to glob()>)
%  Args:  passed to globFolder() -> glob().
%  Returns:
%      list cell:  row of globbed folders stripped of trailing filesep.
%      isdir logical:  row of all trues for folders, matching interface of glob().
%
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1216025 (R2019b) Update 1.  Copyright 2019 John Joowon Lee. 

[list,isdir] = globFolders(varargin{:});
list = list';
isdir = isdir';

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/globFoldersT.m] ======  

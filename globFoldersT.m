function arow = globFoldersT(varargin)
%% GLOBFOLDERST
%  @returns cell row-array of folders, not files, without trailing filesep.
%  Usage:  <folders> = globFoldersT(<args to glob()>)
%
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1216025 (R2019b) Update 1.  Copyright 2019 John Joowon Lee. 

arow = globT(varargin{:});
arefolders = cell2mat(cellfun(@(x) isfolder(x), arow, 'UniformOutput', false));
arow = arow(arefolders);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/globFoldersT.m] ======  

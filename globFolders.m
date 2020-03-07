function acol = globFolders(varargin)
%% GLOBFOLDERS
%  @returns cell column-array of folders.
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1216025 (R2019b) Update 1.  Copyright 2019 John Joowon Lee. 

acol = glob(varargin{:});
arefolders = cell2mat(cellfun(@(x) isfolder(x), acol, 'UniformOutput', false));
acol = acol(arefolders);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/globFolders.m] ======  

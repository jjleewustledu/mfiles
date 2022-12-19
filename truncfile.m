function filepath1 = truncfile(filepath, patt)
%% TRUNCFILE truncates a fully-qualified filepath to patt
%  Args:
%      filepath (folder): to truncate, e.g., '/path/to/desired/extra/extra2'
%      patt (text): e.g., 'desired'
%  Returns:
%      filepath1: e.g., '/path/to/desired'
%
%  Created 22-Jun-2022 19:06:44 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.12.0.1956245 (R2022a) Update 2 for MACI64.  Copyright 2022 John J. Lee.

ss = strsplit(filepath, filesep);
[~,idx] = max(contains(ss, patt));
filepath1 = strcat(filesep, fullfile(ss{1:idx}));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/truncfile.m] ======  

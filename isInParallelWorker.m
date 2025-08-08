function isWorker = isInParallelWorker()

isWorker = isfile('~/bin/mlenv.sh') && exist('getCurrentTask', 'file') && ~isempty(getCurrentTask());

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/isInParallelWorker.m] ======  

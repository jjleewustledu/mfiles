function str = jsonread(fqfn)
%% JSONREAD
%  Args:
%      fqfn text
%  Returns:
%      str struct

str = jsondecode(fileread(fqfn));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/jsonread.m] ======  

function [s,m,mid] = copyExisting(varargin)
%% COPYEXISTING wraps copyfile, checking existence before copying.
%% Developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

dt = mlsystem.DirTool(varargin{1});
for idt = 1:length(dt.fqfns)
    [s,m,mid] = copyfile(dt.fqfns{idt}, varargin{2:end});
end





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/copyExisting.m] ======  

function [t,f] = shiftVector(t, f, dt, varargin)
%% SHIFTVECTOR ... 
%  Usage:  [t,f] = shiftVector(t, f, dt)
%  dt > 0 shifts to right
%  dt < 0 shifts to left
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

ip = inputParser;
addRequired(ip, 't',  @isvector);
addRequired(ip, 'f',  @isvector);
addRequired(ip, 'dt', @isnumeric);
parse(ip, t, f, dt, varargin{:});

[t,f] = mlsystem.VectorTools.shiftVector(t, f, dt);








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/shiftVector.m] ======  

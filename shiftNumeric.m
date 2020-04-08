function [t,f] = shiftNumeric(t, f, dt, varargin)
%% SHIFTNUMERIC ... 
%  Usage:  [t,f] = shiftNumeric(t, f, dt) 
%  dt > 0 shifts to right
%  dt < 0 shifts to left
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

if isscalar(t) && isscalar(f)
    return
end
f = double(f);
if (isvector(f))
    [t,f] = shiftVector(t, f, dt, varargin{:});
else
    [t,f] = shiftTensor(t, f, dt, varargin{:});
end



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/shiftNumeric.m] ======  

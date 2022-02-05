function savemyfig(varargin)
%% SAVEMYFIG saves .fig and .png to the filesystem.
%  Args:
%      handle (matlab.ui.Figure): output of figure() and others.
%      fqfp (text): well-formed 
%
%  Created 27-Jan-2022 16:21:02 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.11.0.1837725 (R2021b) Update 2 for MACI64.  Copyright 2022 John J. Lee.

ip = inputParser;
addRequired(ip, 'handle', @(x) isa(x, 'matlab.ui.Figure'))
addRequired(ip, 'fqfp', @istext)
addParameter(ip, 'close', true, @islogical)
parse(ip, varargin{:})
ipr = ip.Results;

try
    savefig(ipr.handle, strcat(ipr.fqfp, '.fig'))
    figs = get(0, 'children');
    saveas(figs(1), strcat(ipr.fqfp, '.png'))
    if ipr.close
        close(figs(1))
    end
catch ME
    handwarning(ME)
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/savemyfig.m] ======  

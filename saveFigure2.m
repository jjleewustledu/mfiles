function saveFigure2(h, filename, opts)
%% SAVEFIGURE2 has semantics of built-in saveFigure() and savefig(),
%  but saves .fig, .png, .svg.
%
%  Args:
%      h matlab.ui.Figure = gcf
%      filename {mustBeTextScalar} = "Untitled"
%      opts.ext cell = {'.fig', '.png', '.svg'}
%      opts.closeFigure logical = false
%
%  Created 12-Jul-2023 00:44:11 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.14.0.2286388 (R2023a) Update 3 for MACI64.  Copyright 2023 John J. Lee.

arguments
    h matlab.ui.Figure = gcf
    filename {mustBeTextScalar} = stackstr(use_underscores=true)
    opts.ext cell = {'.fig', '.png', '.svg'}
    opts.closeFigure logical = false
end
[pth,fp] = myfileparts(filename);
filename = fullfile(pth, fp);

figure(h);
for pref = asrow(opts.ext)
    saveas(h, string(filename) + pref{1});
end
if opts.closeFigure; close(h); end


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/saveFigure2.m] ======  

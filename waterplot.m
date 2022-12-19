function waterplot(s, f, t)
%% WATERPLOT ~ waterfall plot of spectrogram.
%  See also web(fullfile(docroot, 'signal/ref/pspectrum.html#d124e140812')) .
% 
%  Args:
%      s (numeric): signal
%      f (numeric): vector of frequencies of spectral estimates
%      t (numeric): times of midpoints
%
%  Created 08-Dec-2022 20:09:33 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.13.0.2105380 (R2022b) Update 2 for MACI64.  Copyright 2022 John J. Lee.

    waterfall(f,t,abs(s)'.^2)
    set(gca,XDir="reverse",View=[30 50])
    xlabel("Frequency (Hz)")
    ylabel("Time (s)")

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/waterplot.m] ======  

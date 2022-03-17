function net = compounding(varargin)
%% COMPOUNDING ...
%  Args:
%      yearly_contrib (scalar): yearly contribution, e.g., in US$.
%      N_years (scalar):  default is 30 years.
%      pcnt (%): yearly returns, default is 10% by stocks
%  Returns:
%      net: net return after N_years
%
%  Created 25-Feb-2022 12:52:21 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.11.0.1873467 (R2021b) Update 3 for MACI64.  Copyright 2022 John J. Lee.

ip = inputParser;
addRequired(ip, 'yearly_contrib', @isscalar)
addOptional(ip, 'N_years', 30, @isscalar)
addOptional(ip, 'pcnt', 10, @isscalar)
parse(ip, varargin{:})
ipr = ip.Results;

balance = ipr.yearly_contrib;
multiplier = (1 + ipr.pcnt/100);
for y = 1:(ipr.N_years-1)
    balance = balance * multiplier + ipr.yearly_contrib;
end
net = balance;

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/compounding.m] ======  

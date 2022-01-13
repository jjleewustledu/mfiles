function s = mydatestr(dt, varargin)
%% MYDATESTR specifies datestr with a preferred format
%  Args:
%      dt (numeric): understood by datestr().
%      format (text): param understood by datestr().  Default := 'yyyymmdd'.
%      includetime (logical): param specifying format 'yyyymmddHHMMSS'.
%  Returns:
%      e.g., 'DT20010101' ~ 2001 Jan 1

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.5.0.1049112 (R2018b) Update 3.  Copyright 2019 John Joowon Lee. 

ip = inputParser;
addRequired(ip, 'dt', @isnumeric)
addParameter(ip, 'format', 'yyyymmdd', @istext)
addParameter(ip, 'includetime', false, @islogical)
parse(ip, dt, varargin{:})
ipr = ip.Results;
if ipr.includetime
    ipr.format = 'yyyymmddHHMMSS';
end

s = sprintf('DT%s', datestr(dt, ipr.format));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/datetimestr.m] ======  

function s = mydatetimestr(dt, varargin)
%% MYDATETIMESTR specifies datestr with a preferred format.
%  @param required dt is compatible with datestr.
%  @param subsec is logical, specifying whether to include millisec and microsec; default := false.
%  @param fullstop is char array that does not conflict with 
%         https://www.mathworks.com/help/releases/R2018b/matlab/ref/datestr.html#btenptl-1-formatOut ;
%         otherwise fullstop := '_'.
%  @return char, e.g., 'DT20190317123902.000000'.

%  Version $Revision$ was created 2019 by jjlee,  
%  last modified 20190317 and checked into repository MATLAB-Drive/mfiles,  
%  developed on Matlab 9.5.0.1049112 (R2018b) Update 3.  Copyright 2019 John Joowon Lee. 

ip = inputParser;
addRequired( ip, 'dt', @(x) ~isempty(x));
addParameter(ip, 'subsec', false, @islogical);
addParameter(ip, 'fullstop', '.', @ischar);
parse(ip, dt, varargin{:});
fullstop = ip.Results.fullstop;
subsec = ip.Results.subsec;

if (contains(fullstop, ...
    {'yyyy' 'yy' 'QQ' 'mmmm' 'mmm' 'mm' 'm' 'dddd' 'ddd' 'dd' 'd' 'HH' 'MM' 'SS' 'FFF' 'AM' 'PM'}))
    fullstop = '_';
end
if (~isempty(fullstop) && subsec)
    s = sprintf('DT%s000', datestr(dt, sprintf('yyyymmddHHMMSS%sFFF', fullstop)));
else
    s = sprintf('DT%s', datestr(dt, 'yyyymmddHHMMSS'));
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/datetimestr.m] ======  

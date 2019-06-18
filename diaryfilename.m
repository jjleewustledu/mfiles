function fn = diaryfilename(varargin)
%% DIARYFILENAME
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.5.0.1067069 (R2018b) Update 4.  Copyright 2019 John Joowon Lee. 

ip = inputParser;
addParameter(ip, 'prefix', 'diary', @ischar)
addParameter(ip, 'obj', 'object')
addParameter(ip, 'datetimestr', mydatetimestr(now), @ischar)
parse(ip, varargin{:})
ipr = ip.Results;
if ~ischar(ipr.obj)
    ipr.obj = class(ipr.obj);
end

fn = sprintf('%s_%s_%s.log', ipr.prefix, strrep(ipr.obj, '.', '_'), ipr.datetimestr);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/diaryfilename.m] ======  

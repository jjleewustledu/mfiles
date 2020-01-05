function dt = location2datetime(loc)
%% LOCATION2DATETIME returns the datetime from locations containing 'DT' followed by
%  datetime input format 'yyyyMMddHHmmss'.

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1261785 (R2019b) Update 3.  Copyright 2020 John Joowon Lee. 
try
    re = regexp(loc, '\S*DT(?<adatetime>\d{14})(|.\d+)\S*', 'names');
    dt = datetime(re.adatetime, 'InputFormat', 'yyyyMMddHHmmss');
catch %#ok<CTCH>
    warning('mfiles:RuntimeWarning', 'location2datetime:could not find a datetime in %s', loc)
    dt = NaT;
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/location2datetime.m] ======  

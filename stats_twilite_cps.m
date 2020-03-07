function tbl = stats_twilite_cps(varargin)
%% STATS_TWILITE_CPS ... 
%  Usage:  [date,mean,std] = stats_twilite_cps([date]) 
%                                               ^ datetime obj 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.6.0.1135713 (R2019a) Update 3.  Copyright 2019 John Joowon Lee. 

dates_ = [ ...
    datetime(2016,07,19,13,00,00) ...
    datetime(2016,08,19,13,00,00) ...
    datetime(2016,09,09,13,00,00) ...
    datetime(2016,09,23,13,00,00) ...
    datetime(2016,10,05,13,00,00) ...
    datetime(2016,10,21,13,00,00) ...
    datetime(2016,10,28,13,00,00) ...
    datetime(2016,11,30,13,00,00) ...
    datetime(2016,12,16,13,00,00) ...
    datetime(2017,02,09,13,00,00) ...
    datetime(2017,02,21,13,00,00) ...
    datetime(2017,04,12,13,00,00) ...
    datetime(2017,05,10,13,00,00) ...
    datetime(2017,06,02,13,00,00) ...
    datetime(2017,06,13,13,00,00) ...
    datetime(2017,07,26,13,00,00) ...
    datetime(2017,09,06,13,00,00) ...
    datetime(2017,09,15,13,00,00) ...
    datetime(2017,09,19,13,00,00) ...
    datetime(2017,10,18,13,00,00) ...
    datetime(2017,12,06,13,00,00) ...
    datetime(2018,04,25,13,00,00) ...
    datetime(2018,05,09,13,00,00) ...
    datetime(2018,05,11,13,00,00) ...
    datetime(2018,05,17,13,00,00) ...
    datetime(2018,06,01,13,00,00) ...
    datetime(2018,10,05,13,00,00) ...
    datetime(2018,12,18,13,00,00) ...
    datetime(2019,01,08,13,00,00) ...
    datetime(2019,01,10,13,00,00) ...
    datetime(2019,05,23,13,00,00) ]';
ip = inputParser;
addOptional(ip, 'dates', dates_, @isdatetime)
addParameter(ip, 'doview', true, @islogical)
parse(ip, varargin{:})

d = ip.Results.dates;
m = nan(size(d));
s = nan(size(d));
for id = 1:length(d)
    try
        tc = mlswisstrace.TwiliteCalibration.createFromDate(d(id));
        m(id) = tc.mean_nobaseline;
        s(id) = tc.std_nobaseline;

        if ip.Results.doview
            tc.plotCounts
        end
    catch ME
        handwarning(ME, 'mfiles:FileNotFound', 'stats_twilite_cps.tc->%s', evalc('disp(tc)'))
    end
end

tbl = table(d,m,s, 'VariableNames', {'date' 'mean_twilite_cps' 'std_twilite_cps'});

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/stats_twilite_cps.m] ======  

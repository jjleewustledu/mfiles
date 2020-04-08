function construct_twilite_stats()
%% CONSTRUCT_TWILITE_STATS iterates over CCIRRadMeasurements*.xlsx to generate stats for Twilite.
%  @return activity for aq. [18F]DG measuremnts in cps, decay-adjusted to time of phantom scanning.

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1296695 (R2019b) Update 4.  Copyright 2020 John Joowon Lee. 

HALFLIFE = 6586.272; % [18F] / s
WATER_DENSITY = 0.9982; % g / mL

cd(getenv('CCIR_RAD_MEASUREMENTS_DIR'))
for xlsx = globT('CCIRRadMeasurements*.xlsx')
    crm = mlpet.CCIRRadMeasurements.createFromFilename(xlsx{1});
    dt0 = crm.mMR{1, 'scanStartTime_Hh_mm_ss'};
    dstr = datestr(datetime(crm), 'yyyyMMdd');
    
    for g = globT(fullfile(getenv('CCIR_RAD_MEASUREMENTS_DIR'), 'Twilite', 'CRV', sprintf('*fdg*dt%s.crv', dstr)))
    
        try
            t = mlswisstrace.Twilite('fqfilename', g{1}, 'isotope', 'FDG');
            t.datetime0 = dt0;
            
    
            fprintf('########################################################################################################\n')
            fprintf('file:  %s\n', xlsx{1})
            fprintf('twilite stats:  mean %f, std %f (cps)\n\n', mean(sa), std(sa))
        catch ME
            disp(ME)
        end
    end
    
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/construct_phantom_stats.m] ======  

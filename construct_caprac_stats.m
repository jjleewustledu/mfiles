function construct_caprac_stats()
%% CONSTRUCT_CAPRAC_STATS iterates over CCIRRadMeasurements*.xlsx to generate stats for the well-counter.
%  @return specific activity for aq. [18F]DG measuremnts in Bq/mL with all Caprac calibrations and
%          decay-adjusted to time of phantom scanning.

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1296695 (R2019b) Update 4.  Copyright 2020 John Joowon Lee. 

HALFLIFE = 6586.272; % [18F] / s
WATER_DENSITY = 0.9982; % g / mL

cd(getenv('CCIR_RAD_MEASUREMENTS_DIR'))
for xlsx = globT('CCIRRadMeasurements*.xlsx')
    crm = mlpet.CCIRRadMeasurements.createByFilename(xlsx{1});
    clocks = crm.clocks;
    well = crm.wellCounter;
    mMR = crm.mMR;
    
    rowSelect = strcmp(well.TRACER, '[18F]DG') & ...
        ~isnat(well.TIMECOUNTED_Hh_mm_ss) & ...
        ~isnan(well.MassSample_G) & ...
        ~isnan(well.Ge_68_Kdpm);
    dtime = seconds( ...
        well.TIMECOUNTED_Hh_mm_ss(rowSelect) - ...
        mMR{1, 'scanStartTime_Hh_mm_ss'} + ...
        seconds(clocks{'mMR console', 'TimeOffsetWrtNTS____s'}));
    mass = well.MassSample_G(rowSelect);
    ge68 = well.Ge_68_Kdpm(rowSelect) .* 2.^(dtime/HALFLIFE);
    if isempty(mass) || isempty(ge68)
        continue
    end
    ie = mlcapintec.ApertureCalibration.invEfficiencyf(mass) .* mlcapintec.SensitivityCalibration.invEfficiencyf(ge68);
    
    sa = (1e3/60) * ge68 .* ie * WATER_DENSITY ./ mass; % Bq/mL
    
    fprintf('########################################################################################################\n')
    fprintf('file:  %s\n', xlsx{1})
    fprintf('well stats:  mean %f, std %f (Bq/mL)\n\n', mean(sa), std(sa))
    
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/construct_phantom_stats.m] ======  

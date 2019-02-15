function [carr,tf] = loopRegionalMeasurements
    import mlarbelaez.*;
    if (strcmp(license, '847712'))
        sDir = '/Volumes/SeagateBP4/Arbelaez/GluT'; 
        diary(fullfile(sDir, sprintf('%s_diary_%s.log', mfilename, datestr(now, 30)))); 
    else
        sDir = '/scratch/jjlee/Arbelaez/GluT';
    end
    
    t0   = tic; 
    cd(sDir);
    dns  = {'p7873_JJL' 'p7901_JJL' 'p7926_JJL' 'p7935_JJL' ...
            'p7954_JJL' 'p7979_JJL' 'p7991_JJL' 'p8015_JJL' ...
            'p8018_JJL' 'p8039_JJL' 'p8042_JJL' 'p8047_JJL'};
    
    carr = cell(12,2,5);
    parfor d = 1:12 % length(dns)      
        for s = 1:2
            regions = {'amygdala' 'hippocampus' 'large-hypothalamus' 'mpfc' 'thalamus'};
            for r = 1:5
                try
                    t1 = tic;
                    fprintf('--------------------------------------------------------------------------------------\n');
                    fprintf('%s:  is working with %s scanIndex %i region %s\n', mfilename, dns{d}, s, regions{r});
                    rm = RegionalMeasurements(fullfile(sDir, dns{d}, ''), s, regions{r});
                    [v,rm] = rm.vFrac;
                    [f,rm] = rm.fFrac;
                    [k,rm] = rm.kinetics4; k = k.parameters;
                    carr{d,s,r} = struct('v', v, 'f', f, 'k4parameters', k);
                    fprintf('v = %g\n', rm.vFrac);
                    fprintf('f = %g\n', rm.fFrac);
                    fprintf('k4parameters = %s\n', num2str(rm.kinetics4.parameters));                    
                    %if (strcmp(license, '847712'))
                    %    save(fullfile(sDir, dns{d}, sprintf('%s_regionalMeasurements_%s.mat', mfilename, datestr(now, 30))), 'rm');
                    %end
                    
                    fprintf('--------------------------Elapsed time is %g seconds---------------------------\n\n', toc(t1));
                catch ME
                    disp(ME)
                    struct2str(ME.stack)
                    handwarning(ME);
                end
            end
        end
    end
    cd(sDir);
    save(fullfile(sDir, sprintf('%s_%s.mat', mfilename, datestr(now, 30))), '-v7.3');
    tf = toc(t0);
    
    if (strcmp(license, '847712'))
        diary off; 
    end
end

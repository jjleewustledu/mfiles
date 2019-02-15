function [dt,ks,rk4s] = loopRegionalKinetics4

    t0 = tic %#ok<*NOPRT>
    import mlarbelaez.* mlsystem.*;   
    registry = ArbelaezRegistry.instance;
    cd(registry.subjectsDir);
    
    dt    = DirTool(registry.sessionNamePattern); 
    fqdns = dt.fqdns; % avoid parfor broadcasting overhead
    dns   = dt.dns;   % 
    assert(~isempty(dns));
    regions = registry.regionLabels;
    ks      = cell(length(dt.dns), 2, length(regions));
    rk4s    = cell(length(dt.dns), 2, length(regions));

    for d = 11:11 % parfor d = 1:length(dt)
        for s = 1:2
            for r = 3:3 % 1:length(REGIONS)
                try
                    cd(fqdns{d});
                    fprintf('--------------------------------------------------------------------------------------\n');
                    fprintf('%s:  is working with %s scanIndex %i region %s\n', mfilename,  dns{d}, s, regions{r});
                    [ks{d,s,r},rk4s{d,s,r}] = RegionalKinetics4.run( ...
                                              RegionalMeasurements(fqdns{d}, s, regions{r}));
                catch ME
                    handwarning(ME)
                end
            end    
        end
    end
    
    cd(registry.subjectsDir);
    save(fullfile(registry.subjectsDir, ...
                  sprintf('loopKinetics4_regional_%s.mat', datestr(now, 30))));  
    tf = toc(t0) %#ok<NASGU>
end
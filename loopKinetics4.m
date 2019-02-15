function [dt,ks,kmps] = loopKinetics4

    t0 = tic %#ok<*NOPRT>
    subjectsPth = fullfile('/home/jjlee', 'Arbelaez', 'GluT', '');
    cd(subjectsPth);
    runLabel = fullfile(subjectsPth, sprintf('loopKinetics4_Kinetics4McmcProblem_%s', datestr(now, 30)));
    %diary([runLabel '.log']);
    
    import mlarbelaez.* mlsystem.*;   
    
    dt   = DirTool('p*_JJL'); dns = dt.dns;
    assert(~isempty(dt.dns));
    ks   = cell(length(dt.dns),2);
    kmps = cell(length(dt.dns),2);

    parfor d = 1:length(dns)
        for s = 1:2
            try
                pth = fullfile(subjectsPth, dns{d}, '');
                cd(pth);
                fprintf('-------------------------------------------------------------------------------------------------------------------------------\n');
                fprintf('loopKinetics4:  working in %s scanIndex %i\n', pth, s);
                [ks{d,s},kmps{d,s}] = Kinetics4McmcProblem.run(pth, s);
            catch ME
                handwarning(ME)
            end
        end                
    end
    
    cd(subjectsPth);
    save([runLabel '.mat']);            
    tf = toc(t0) %#ok<NASGU>
    %diary off

end
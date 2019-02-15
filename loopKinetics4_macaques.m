function [dt,ks,kmps] = loopKinetics4_macaques

    t0 = tic %#ok<*NOPRT>
    subjectsPth = fullfile('/home/jjlee', 'Arbelaez', 'pet6_c11monkey', '');
    cd(subjectsPth);
    runLabel = fullfile(subjectsPth, sprintf('loopKinetics4_macaques_Kinetics4McmcProblem_%s', datestr(now, 30)));
    %diary([runLabel '.log']);
    
    import mlarbelaez.* mlsystem.*;   
    
    dt   = DirTool('M*'); dns = dt.dns;
    assert(~isempty(dt.dns));
    ks   = cell(length(dt.dns),2);
    kmps = cell(length(dt.dns),2);

    parfor d = 1:length(dns)
        hemispheres = {'left' 'right'};
        for h = 1:2
            try
                pth = fullfile(subjectsPth, dns{d}, '');
                cd(pth);
                fprintf('-------------------------------------------------------------------------------------------------------------------------------\n');
                fprintf('loopKinetics4_macaques:  working in %s scanIndex %i\n', pth, hemispheres{h});
                [ks{d,h},kmps{d,h}] = Kinetics4McmcProblem.runMacaque(pth, hemispheres{h});
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
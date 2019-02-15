function [ks,kmps] = bootstrapKinetics4(N,M)

    t0 = tic %#ok<*NOPRT>
    subjectsPth = fullfile('/home/jjlee', 'Arbelaez', 'GluT', 'p8039_JJL', '');
    cd(subjectsPth);
    runLabel = fullfile(subjectsPth, sprintf('bootstrapKinetics4_Kinetics4McmcProblem_%s', datestr(now, 30)));
    diary([runLabel '.log']);
    
    import mlarbelaez.*;   
    
    ks   = cell(N,M,2);
    kmps = cell(N,M,2);

    parfor n = 1:N
        for m = 1:M
            try
                rng('shuffle');

                fprintf('-------------------------------------------------------------------------------------------------------------------------------\n');
                fprintf('bootstrapKinetics4:  working in %s scanIndex %i parfor n->%i for m->%i\n', subjectsPth, 2, n, m);
                [ks{n,m,2},kmps{n,m,2}] = Kinetics4McmcProblem.run(subjectsPth, 2);
            catch ME
                handwarning(ME)
            end
        end                
    end
    
    cd(subjectsPth);
    save([runLabel '.mat']);            
    tf = toc(t0) %#ok<NASGU>
    diary off

end
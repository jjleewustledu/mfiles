function [ks,kmps] = singleKinetics4
    
    %ip = inputParser;
    %addRequired(ip, 'folder', @ischar);
    %parse(ip, folder);

    subjectPth = fullfile('/home/jjlee', 'Arbelaez', 'GluT', 'p7996_JJL', '');
    scanIndex = 2;
    cd(subjectPth);
    assert(lexist(subjectPth, 'dir'));
    runLabel = fullfile(subjectPth, sprintf('singleKinetics4_Kinetics4McmcProblem_%s', datestr(now, 30)));
    diary([runLabel '.log']);

    fprintf('-------------------------------------------------------------------------------------------------------------------------------\n');
    fprintf('%s:  working in %s scanIndex %i\n', mfilename, subjectPth, scanIndex);
    
    t0 = tic %#ok<*NOPRT>
    [ks,kmps] = mlarbelaez.Kinetics4McmcProblem.run(subjectPth, scanIndex);                
    tf = toc(t0) %#ok<NASGU>
               
    save([runLabel '.mat']);            
    diary off

end
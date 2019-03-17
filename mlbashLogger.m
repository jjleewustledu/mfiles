function [s,r] = mlbashLogger(cmdline, logger)
    %% MLBASHLOGGER
    %  Version $Revision$ was created 2016 by jjlee,
    %  last modified 20190313 160902 and checked into git repository MATLAB-Drive/mfiles.
    %  Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 

    ip = inputParser;
    addRequired( ip, 'cmdline', @ischar);
    addRequired( ip, 'logger', @(x) isa(x, 'mlpipeline.ILogger'));
    parse(ip, cmdline, logger);

    [s,r] = system(cmdline);
    logger.add(sprintf('mlbashLogger.cmdline:  %s\n', cmdline));
    logger.add(sprintf('mlbashLogger.s:  %i\n', s));
    logger.add(sprintf('mlbashLogger.r:\n%s\n', r));
    if (s ~= 0)
        error('mfiles:ChildProcessError', 'mlbashLogger:\n%s\nreturned s->%i\n%s', cmdline, s, r);
    end
end





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/mlbashLogger.m] ======  

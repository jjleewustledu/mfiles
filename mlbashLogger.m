function [s,r] = mlbashLogger(cmdline, logger)
%% MLBASHLOGGER
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

    ip = inputParser;
    addRequired( ip, 'cmdline', @ischar);
    addRequired( ip, 'logger', @(x) isa(x, 'mlpipeline.Logger'));
    parse(ip, cmdline, logger);

    [s,r] = unix(cmdline);
    logger.add(sprintf('mlbashLogger.cmdline:\n%s\n', cmdline));
    logger.add(sprintf('mlbashLogger.s:  %i\n', s));
    logger.add(sprintf('mlbashLogger.r:\n%s\n', r));
end





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/mlbashLogger.m] ======  

function [s,r] = mlbashDiary(cmdline, diaryfn)
    %% MLBASHDIARY
    %  Version $Revision$ was created 2016 by jjlee,  
    %  last modified 20190313 160638 and checked into git repository MATLAB-Drive/mfiles.
    %  Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 

    ip = inputParser;
    addRequired( ip, 'cmdline', @ischar);
    addRequired( ip, 'diaryfn', @ischar);
    parse(ip, cmdline, diaryfn);

    diary(diaryfn);
    fprintf('mlbashDiary.cmdline:  %s\n', cmdline);
    try
        [s,r] = system(cmdline);
        fprintf('mlbashDiary.s:  %i\n', s);
        fprintf('mlbashDiary.r:\n%s\n', r);
        diary('off');
    catch ME
        diary('off');
        rethrow(ME);
    end
    if (s ~= 0)
        error('mfiles:ChildProcessError', 'mlbashDiary:\n%s\nreturned s->%i\n%s', cmdline, s, r);
    end
end



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/mlbashDiary.m] ======  

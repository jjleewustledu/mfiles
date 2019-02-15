function [s,r] = mlbashDiary(cmdline, diaryfn)
%% MLBASHDIARY
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

    ip = inputParser;
    addRequired( ip, 'cmdline', @ischar);
    addRequired( ip, 'diaryfn', @ischar);
    parse(ip, cmdline, diaryfn);

    diary(diaryfn);
    [s,r] = unix(cmdline);
    fprintf('mlbashDiary.cmdline:\n%s\n', cmdline);
    fprintf('mlbashDiary.s:  %i\n', s);
    fprintf('mlbashDiary.r:\n%s\n', r);
    diary('off');
end



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/mlbashDiary.m] ======  

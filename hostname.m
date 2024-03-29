function h = hostname()
    %% HOSTNAME 
    %  @returns hostname -s
    %  Version $Revision$ was created 2016 by jjlee,  
    %  last modified 20190313 172852 and checked into repository MATLAB-Drive/mfiles,  
    %  developed on Matlab 9.1.0.441655 (R2016b).  Copyright 2017 John Joowon Lee. 

    try
        [s,h] = system('hostname -f'); h = strtrim(h);
        if (s ~= 0)
            [s,h] = system('hostname'); h = strtrim(h);
        end
    catch ME
        handwarning(ME);
        h = 'unknown_host';
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/hostname.m] ======  

function filenames = ensureGunzip(gzipfilenames, outputfolder)
%% ENSUREGUNZIP 
%  Created 14-Oct-2023 20:35:17 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 23.2.0.2380103 (R2023b) Update 1 for MACI64.  Copyright 2023 John J. Lee.

arguments
    gzipfilenames {mustBeText}
    outputfolder {mustBeFolder} = pwd
end

filenames = "";
gzipfilenames = convertCharsToStrings(gzipfilenames);
for gi = 1:length(gzipfilenames)
    if ~isfolder(fullfile(outputfolder, mybasename(gzipfilenames(gi))))
        filenames(gi) = convertCharsToStrings( ...
            gunzip(gzipfilenames(gi)));
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/ensureGunzip.m] ======  

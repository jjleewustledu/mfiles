function paths = mglob(p)
%% MGLOB provides convenient access to matlab.buildtool.io.filecollection.frompaths.
%  See also web(fullfile(docroot, 'matlab/ref/matlab.buildtool.io.filecollection.frompaths.html'))
%  Args:
%      p {mustBeText}
%  Returns:
%      paths string, as row
%
%  Created 05-Oct-2023 16:40:10 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 23.2.0.2380103 (R2023b) Update 1 for MACI64.  Copyright 2023 John J. Lee.

arguments
    p {mustBeText}
end

try
    fc = matlab.buildtool.io.FileCollection.fromPaths(p); % maybe unavailable
    paths = fc.paths;
    return
catch %ME
    %fprintf("%s: %s\n", stackstr(), ME.message);
end

fc = glob(convertStringsToChars(p));
fc = asrow(fc);
paths = convertCharsToStrings(fc);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/mglob.m] ======  

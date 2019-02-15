function fqfns = scrubFqFilenames(fqfns, labels)
%% SCRUBFQFILENAMES removes string labels from fully-qual. filenames
%  Usage:   fq_filenames = scrubFqFilenames(fq_filenames, labels)
%           ^                               ^             ^ string, cell-array of
%
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/scrubFqFilenames.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

if (ischar(fqfns))
    fqfns = {fqfns}; 
end
if (ischar(labels))
    labels = {labels};
end
for f = 1:length(fqfns)
    [pth,fp,ext] = fileparts(fqfns{f});
    for b = 1:length(labels)
        fp       = fileprefix(fp, labels{b});
    end
    fqfns{f} = fullfile(pth, [fp ext]);
end
if (1 == length(fqfns))
    fqfns = fqfns{1};
end


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/scrubFqFilenames.m] ======  

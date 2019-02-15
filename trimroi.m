function [trimmed, trimmer] = trimroi(totrim, trimmers, thrPcnt)
%% TRIMROI trims away unwanted parts of ROIs, saving to filesystem and returning NIfTI
%   
%  Usage:  [trimmed,trimmer] = trimroi(totrim, trimmers, threshPercent) 
%           ^ NIfTI ROI                ^ ROI as NIfTI or fileprefix
%                                              ^ cell-array of ROIs, NIfTI or fileprefix
% 
%% Version $Revision: 1220 $ was created $Date: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/trimroi.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 
import mlfourd.*;
if (~exist('thrPcnt', 'var')) thrPcnt = 25; end

if (ischar(totrim))
    totrim = NIfTI.load(totrim);
else
    totrim = NIfTI(totrim);
end

if (~iscell(trimmers))
    trimmers = {trimmers}; 
end
    trimmer  = totrim.zeros;
for t = 1:length(trimmers) %#ok<*FORFLG>
    if (ischar(trimmers{t}))
        trimmers{t} = NIfTI.load(trimmers{t});
    else
        trimmers{t} = NIfTI(     trimmers{t});
    end
    trimmer = trimmer + trimmers{t};
end
trimmer            = NiiBrowser(trimmer);
trimmer            = trimmer.thrP(thrPcnt);
trimmer            = trimmer.uthr(1);
trimmed            = totrim .* (trimmer.ones - trimmer);
movefile(totrim.filename, [totrim.fileprefix '_bak.nii.gz']);
trimmed.fileprefix = totrim.fileprefix;
trimmed.save;






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/trimroi.m] ======  

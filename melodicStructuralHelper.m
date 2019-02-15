function melodicStructuralHelper(pth0, vb)
%% MELODICHELPER writes shell sets to the cmd window   
%  Usage:  melodicHelper(root_path, cell_array_of_VBLabels) 
%          
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/melodicStructuralHelper.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$

BOLDS_PER_VB = 12;
INDEXING_OFFSET = 0;

if (isempty(pth0)); pth0 = '/Volumes/PassportStudio/cvl/np705/NP705_Orig'; end
idx = INDEXING_OFFSET;
for vIdx = 1:length(vb)
    for boldIdx = 1:BOLDS_PER_VB
        idx = idx + 1;
        fprintf('# Subject''s structural image for analysis %i\n', idx);
        fprintf(...
            'set highres_files(%i) "%s/%s/atlas/%s_mpr1.4dfp_brain"\n\n', ...
             idx, pth0, vb{vIdx}, vb{vIdx});
    end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/melodicHelper.m] ======  

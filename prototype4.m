function [xvec,unused_indices] = prototype4(imobj, indices, normalize)
%% PROTOTYPE using aparc.a2009s+aseg for ROIs 
%  Usage:  [intensities,unused_indices] = prototype4(image, indices, normalize) 
%          ^            ^ double vecs                ^ NIfTI or filename
%                         ordinal indices                            ^ double ^ scalar double

%% Version $Revision: 2433 $ was created $Date: 2013-05-02 02:44:43 -0500 (Thu, 02 May 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-05-02 02:44:43 -0500 (Thu, 02 May 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/prototype4.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

cd('/Volumes/PassportStudio2/test/np755/mm01-020_p7377_2009feb5/fsl');
import mlfourd.*;
imobj  = imcast(imobj, 'mlfourd.NIfTI');
assert(isnumeric(indices));
if (~exist('normalize', 'var'))
    normalize = 1; end

aparc = NIfTI.load('aparc_nocsf_on_rawavg.nii.gz');
wm    = NIfTI.load('bin_wm_seg_on_rawavg.nii.gz');
cereb = NIfTI.load('../../MNI152_T1_2mm_cerebellum_mask_on_t1_005.nii.gz');
pca   = NIfTI.load('../../MNI152_T1_2mm_mask_PCA_on_t1_005.nii.gz');
%left  = NIfTI.load('../../left_MNI_on_t1_005.nii.gz');
% sl14to46 = cereb.makeSimilar(zeros(size(cereb)), 'slices14to46', 'slices14to46');
% for sl = 14:46
%     sl14to46.img(:,:,sl) = ones(cereb.size(1), cereb.size(2));
% end
aparc = aparc .* ~wm .* ~cereb .* ~pca;

xvec = zeros(size(indices));
unused_indices = [];
for sl = 1:length(indices)
    trues = aparc.img == indices(sl);
    if (sum(trues(:)) > 32)
        xvec(sl) = mean(imobj.img(trues)) / normalize; %% reindexing
    else
        unused_indices = [unused_indices sl]; %#ok<AGROW>
    end
end

end
 
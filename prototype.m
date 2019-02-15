function [indices] = prototype(o15, lbl)
%% PROTOTYPE using aparc.a2009s+aseg for ROIs for cortical thickness and PET... 
%  Requires subsequent implementation of http://surfer.nmr.mgh.harvard.edu/fswiki/VolumeRoiCorticalThickness 
%  Usage:  indices = prototype([O15]-pet-image) 
%          ^ cell-array         ^ NIfTI or filename

%% Version $Revision: 2433 $ was created $Date: 2013-05-02 02:44:43 -0500 (Thu, 02 May 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-05-02 02:44:43 -0500 (Thu, 02 May 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/prototype.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

cd('/Volumes/PassportStudio2/test/np755/mm01-020_p7377_2009feb5/fsl');
import mlfourd.*;
o15 = imcast(o15, 'mlfourd.NIfTI');
%cho   = NIfTI.load('cho_f5to24_on_t1_005_gauss3p8391mm_gauss3p8391mm.nii.gz');
%coo   = NIfTI.load('coo_f7to26_on_t1_005_gauss3p8391mm_gauss3p8391mm_gauss3p8391mm.nii.gz');
%coo.fileprefix = 'coo_aparc';
aparc = NIfTI.load('aparc_nocsf_on_rawavg.nii.gz');
o15_aparc = o15.makeSimilar(zeros(o15.size), lbl, lbl);
indices = []; ii = 1;

for sl = 1:aparc.dipmax % 0:255, 11100:aparc.dipmax
    trues = aparc.img == sl;
    if (any(trues(:)))
        fprintf('working on index %i\n', sl);
        indices(ii) = sl; ii = ii + 1; %#ok<AGROW>
        lbl = sprintf('roi_%i', sl);
        roi = aparc.makeSimilar(trues, lbl, lbl); roi.save;
        m = mean(o15.img(trues));
        o15_aparc.img(trues) = m;
    end
end
o15_aparc.save;

end
 
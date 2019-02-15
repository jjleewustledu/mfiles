function [thick] = prototype3(collection)
%% PROTOTYPE using aparc.a2009s+aseg for ROIs for cortical thickness and PET... 
%  Requires subsequent implementation of http://surfer.nmr.mgh.harvard.edu/fswiki/VolumeRoiCorticalThickness 
%  Usage:  indices = prototype() 
%          ^ cell-array

%% Version $Revision: 2433 $ was created $Date: 2013-05-02 02:44:43 -0500 (Thu, 02 May 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-05-02 02:44:43 -0500 (Thu, 02 May 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/prototype3.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

cd('/Volumes/PassportStudio2/test/np755/mm01-020_p7377_2009feb5/fsl');
import mlfourd.*;
thick = NIfTI.load('t1.nii.gz');
thick.fileprefix = 'thickness_on_aparc_nocsf';
%coo   = NIfTI.load('coo_f7to26_on_t1_005_gauss3p8391mm_gauss3p8391mm_gauss3p8391mm.nii.gz');
%coo.fileprefix = 'coo_aparc';
aparc = NIfTI.load('aparc_nocsf_on_rawavg.nii.gz');
aparc.fileprefix = 'aparc_nocsf_on_rawavg';
thick = aparc.makeSimilar(zeros(aparc.size), 'thickness_on_aparc_nocsf', 'thickness_on_aparc_nocsf');
thick.fileprefix = 'thickness_on_aparc_nocsf';

for sl = 1:aparc.dipmax
    trues = aparc.img == sl;
    if (0 ~= sum(sum(sum(trues))))
        thick.img(trues) = collection(sl);
        %imshow(squeeze(sum(trues,3)));
    end
end
thick.save;
end
 
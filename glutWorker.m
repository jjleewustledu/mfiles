function glutWorker()
%% GLUTWORKER 
%  Usage:  glutWorker() 
%           
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

pwd0 = pwd;
dt = mlsystem.DirTool('p*_JJL*');
assert(~isempty(dt.dns));

import mlfourd.*;
% for d = 1:dt.length
%     for s = 1:2
%         out = '';
%         try
%             %pth = fullfile(pwd0, dt.dns{d}, 'PET', sprintf('scan%i', s), '');
%             %fprintf('glutWorker is working with %s\n', f);
%             
% %             f   = fullfile(pth, sprintf('%sgluc%i_161616fwhh.nii.gz', str2pnum(dt.dns{d}), s));
% %             f1  = fullfile(pth, sprintf('%sgluc%i_161616fwhh_mcf.nii.gz', str2pnum(dt.dns{d}), s));
% %             f2  = fullfile(pth, sprintf('%sgluc%i_mcf.nii.gz', str2pnum(dt.dns{d}), s));
% %             f0  = fullfile(pth, sprintf('%sgluc%i.nii.gz', str2pnum(dt.dns{d}), s));
% %             mat = fullfile(pth, sprintf('%sgluc%i_161616fwhh_mcf.mat', str2pnum(dt.dns{d}), s));
%             
% %             nii  = NIfTI.load(sprintf('%sgluc%i.nii.gz', str2pnum(dt.dns{d}), s));
% %             niib = NiiBrowser(nii);
% %             niib = niib.blurredBrowser4d([16 16 16]);
% %             niib.save;
% 
%             %system(sprintf('mcflirt -in %s -refvol 21 -meanvol -stats -mats -plots -report', f));
%             %system(sprintf('applyxfm4D %s %s %s %s -fourdigit', f0, f0, f2, mat));
%             %[~, out] = system(sprintf('freeview %s', f2));
%             
%         catch ME
%             handwarning(ME);
%             fprintf(out);
%         end
%     end
% end
% 
% for d = 1:dt.length
%     try        
%         pth = fullfile(pwd0, dt.dns{d}, 'fsl', '');
%         fprintf('glutWorker is working in %s\n', pth);
%         cd(pth);
%         if (~lexist('brain.finalsurfs.nii.gz', 'file'))
%             system('cp ../freesurfer/mri/brain.finalsurfs.mgz .');
%             system('mri_convert brain.finalsurfs.mgz brain.finalsurfs.nii.gz');
%         end
%     catch ME
%         handwarning(ME);
%     end
% end
% 
% for d = 1:dt.length
%     for s = 1:2
%         try        
%             pth = fullfile(pwd0, dt.dns{d}, 'PET', sprintf('scan%i', s), '');
%             fprintf('glutWorker is working in %s\n', pth);
%             cd(pth);
%             nii = NIfTI.load(sprintf('%sgluc%i_mcf.nii.gz', str2pnum(dt.dns{d}), s));
%             nii = sum(nii, 4);
%             nii.save;
%         catch ME
%             handwarning(ME);
%         end
%     end
% end
% 
% for d = 1:dt.length
%     for s = 1:2
%         try    
%             fslpth = fullfile(pwd0, dt.dns{d}, 'fsl', '');
%             petpth = fullfile(pwd0, dt.dns{d}, 'PET', sprintf('scan%i', s), '');
%             fprintf('glutWorker is working with %s\n', petpth);
%             cd(fslpth);
%             system(sprintf('ln -s %s/%sgluc%i_mcf.nii.gz', petpth, str2pnum(dt.dns{d}), s));
%             system(sprintf('ln -s %s/"(sum)%sgluc%i_mcf.nii.gz"', petpth, str2pnum(dt.dns{d}), s));
%             system(sprintf('ln -s %s/%str%i.nii.gz',            petpth, str2pnum(dt.dns{d}), s));
%         catch ME
%             handwarning(ME);
%         end
%     end
% end


for d = 1:dt.length
    try    
        fslpth = fullfile(pwd0, dt.dns{d}, 'fsl', '');
        fspth  = fullfile(pwd0, dt.dns{d}, 'freesurfer', 'mri', '');
        fprintf('glutWorker is working with %s\n', fslpth);
        cd(fslpth);
        if (~lexist('aparc_a2009s+aseg.nii.gz', 'file'))
            system(sprintf('cp %s/aparc.a2009s+aseg.mgz .', fspth));
            system(sprintf('mri_convert aparc.a2009s+aseg.mgz aparc_a2009s+aseg.nii.gz'));
        end
    catch ME
        handwarning(ME);
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/glutWorker.m] ======  

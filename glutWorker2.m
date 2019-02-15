function glutWorker2()
%% GLUTWORKER2 ... 
%   
%  Usage:  glutWorker2() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

cd('/Volumes/PassportStudio2/Arbelaez/GluT');
pwd0 = pwd;
studies = {'p8039' 'p8042'};
for st = 1:length(studies)
    for sc = 1:2
        cd(sprintf('%s_JJL_/PET/scan%i', studies{st}, sc));
        nii = mlfourd.NIfTI.load(sprintf('%sgluc%i_mcf.nii.gz', studies{st}, sc));
        nii.img = nii.img(:,:,:,1:44);
        nii.save;
        cd(pwd0);
    end    
end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/glutWorker2.m] ======  

function nii = sumPet(nii, range)
%% SUMPET sums time-frames of PET embedded in NIfTI
%   
%  Usage:  nifti_summed = sumPet(nifti, [first_frame last_frame]) 
%                                       ^ 1x2 double 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

assert(isnumeric(range));
assert(all([1 2] == size(range)));

img = zeros(nii.size);
img = img(:,:,:,1);
for f = range(1):range(2)
    img = img + nii.img(:,:,:,f);
end
nii.img = img;
nii.fileprefix = sprintf('%s_f%ito%i', nii.fileprefix, range(1), range(2));








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/sumPet.m] ======  

function pet = maskPet(pet, msk)
%% MASKPET accepts PET and mask NIfTIs and masks each time-frame of PET by the mask
%  Usage:  pet_masked_nifti = maskPet(pet_nifti, mask_nifti) 
%           
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

assert(isa(pet, 'mlfourd.NIfTI'));
assert(isa(msk, 'mlfourd.NIfTI'));
assert(3 == length(msk.size));

for t = 1:pet.size(4)
    pet.img(:,:,:,t) = pet.img(:,:,:,t) .* msk.img;
end
pet.fileprefix = [pet.fileprefix '_masked'];








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/maskPet.m] ======  

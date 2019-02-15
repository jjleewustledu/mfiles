function times = plotPet(nii, niimsk)
%% PLOTPET plots the time-evolution of the PET data summed over all positions from the tomogram
%  Usage:  times = plotPet(PET_NIfTI, mask_NIfTI) 
%          ^ double vector
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

assert(isa(nii,    'mlfourd.NIfTI'));
assert(isa(niimsk, 'mlfourd.NIfTI'));
assert(4 == length(nii.size), 'plotPet:  PET NIfTI has no temporal data');
nii_size = nii.size;
assert(all(nii_size(1:3) == niimsk.size));

times = zeros(1,nii.size(4));
for t = 1:nii.size(4)
    times(t) = sum(sum(sum(nii.img(:,:,:,t) .* niimsk.img, 1), 2), 3);
end
plot(times);








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/plotPet.m] ======  

function nii = mean_of_relative_means(niilist)
%% MEAN_OF_RELATIVE_MEANS ... 
%   
%  Usage:  nii = mean_of_relative_means(nii0) 
%          ^                            ^ NIfTI
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.10.0.499 (R2010a) 
%% $Id$ 

nii = 0;
for n = 1:length(niilist)
    nii = nii + niilist{n}./mean(dip_image(niilist{n}.img));
end
nii = nii./length(niilist);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mfiles/mean_of_relative_means.m] ======  

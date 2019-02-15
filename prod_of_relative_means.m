function nii = prod_of_relative_means(niilist)
%% PROD_OF_RELATIVE_MEANS ... 
%   
%  Usage:  nii = prod_of_relative_means(niilist) 
%          ^                            ^ NIfTI
%
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.10.0.499 (R2010a) 
%% $Id$ 

nii = 1;
for n = 1:length(niilist)
    nii = nii .* niilist{n} ./ mean(dip_image(niilist{n}.img));
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mfiles/prod_of_relative_means.m] ======  

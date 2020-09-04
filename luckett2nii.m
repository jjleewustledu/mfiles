function ic = luckett2nii(fn)
%% LUCKETT2NII converts hdr/img files to compressed single-file NIfTI with flip(,2).  
%  Usage:  nii = luckett2nii('data.hdr')
%  @param filename 
%  @return writes NIfTI with identical fileprefix, clobbering any existing files.
%  @return mlfourd.ImagingContext2.
%           
%% developed on Matlab 9.8.0.1417392 (R2020a) Update 4.  Copyright 2020 John Joowon Lee. 

assert(contains(fn, '.hdr'))
[~,fp] = myfileparts(fn);
ic = mlfourd.ImagingContext2(fn);
ic = flip(ic, 2);
ic.filename = [fp '.nii.gz'];
ic.save()

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/luckett2nii.m] ======  

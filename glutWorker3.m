function glutWorker3(snum)
%% GLUTWORKER3 ... 
%   
%  Usage:  glutWorker3() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

assert(isnumeric(snum));
pnum    = str2pnum(pwd);
sumGluc = sprintf('"(sum)%sgluc%i_mcf"', pnum, snum);
brain   = sprintf('brain_finalsurfs_on_%str%i', pnum, snum);
tr      = sprintf('%str%i', pnum, snum);
nu      = sprintf('nu_noneck_on_%str%i', pnum, snum);
aparc   = 'aparc_a2009s+aseg';

assert(lexist(sprintf('%s.nii.gz', sumGluc), 'file'));
assert(lexist(sprintf('%s.nii.gz', aparc),   'file'));

system(sprintf('fslview %s %s %s %s &', sumGluc, brain, tr, nu));

system(sprintf('flirt -in %s -applyxfm -init %s.mat -out %s_on_%s -paddingsize 0.0 -interp nearestneighbour -ref %s', aparc, nu, aparc, tr, tr));



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/glutWorker3.m] ======  

function roi = blurThenBinarize(roi, mpr)
%% BLURTHENBINARIZE ... 
%   
%  Usage:  roi = blurThenBinarize(roi, mpr) % string or NIfTId args
%           
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.5.0.197613 (R2015a) 
%% $Id$ 

import mlfourd.*;
if (ischar(roi))
    roi = NIfTId.load(roi);
end
if (ischar(mpr))
    mpr = NIfTId.load(mpr);
end
img = roi.img;

mpr.img = img;
mpr.fqfilename = roi.fqfilename;



assert(mpr.rank == 3, 'rank(%s)->%i', mpr.fqfilename, mpr.rank);
bnii = BlurringNIfTId(mpr, 'blur', mlpet.PETRegistry.instance.petPointSpread);
thresh = max(max(max(bnii.img)))/10;
bnii.img = double(bnii.img > thresh);
assert(~strcmp(bnii.fileprefix, mpr.fileprefix));
bnii.save;
roi = bnii.component;

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/blurThenBinarize.m] ======  

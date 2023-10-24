function str = leftAndRight(nii, Lmsk, Rmsk, pnum, debug)
%% LEFTANDRIGHT ... 
%   
%  Usage:  str = leftAndRight(nifti, Lmask, Rmask, 1) 
%          ^     str contains left values, right values, ratio left/right
%                             ^ 3 NIfTIs
%                                                  ^ optional debug request displays images
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

import mlfourd.*;
assert(nargin >= 3);
if (ischar(nii))
    nii = NIfTI.load(nii);
end
if (ischar(Lmsk))
    Lmsk = NIfTI.load(Lmsk);
end
if (ischar(Rmsk))
    Rmsk = NIfTI.load(Rmsk);
end

assert(isa(nii,  'mlfourd.INIfTI'));
assert(isa(Lmsk, 'mlfourd.INIfTI')); assert(~isa(Lmsk, 'mlfourd.NIfTI_mask'));
assert(isa(Rmsk, 'mlfourd.INIfTI')); assert(~isa(Rmsk, 'mlfourd.NIfTI_mask'));

if (exist('debug', 'var'))
    switch (uint8(debug))
        case 1
            mlbash(strcat('slices ', nii.fileprefix));
        case {2,3}
            mlbash(strcat('slices ', nii.fileprefix));
            mlbash(strcat('slices ', Lmsk.fileprefix));
            mlbash(strcat('slices ', Rmsk.fileprefix));
        otherwise
    end
end

Lmsk = Lmsk.forceSingle;
Rmsk = Rmsk.forceSingle; 

L = nii .* Lmsk;
L = L.dipsum / Lmsk.dipsum;

R = nii .* Rmsk;
R = R.dipsum / Rmsk.dipsum;

if (strfind(nii.fileprefix, 'ho'))
    pimg  = mlfsl.PETStudy(pnum);
    hdrfn = pimg.hdrinfo_filename('ho1_g3');
    import mlpet.*;
    L     = PETBuilder.count2cbf(L, hdrfn, true);
    R     = PETBuilder.count2cbf(R, hdrfn, true);
end

str = sprintf('%s <L> <R> <L>/<R>:  %g \t %g \t %g \n', nii.label, L, R, L/R);
%     fprintf('%s', str);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/leftAndRight.m] ======  

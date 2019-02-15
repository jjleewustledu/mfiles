function final = maskSumtBecq(ecatfn, maskfn, artfn)
%% maskSumtBecq ... 
%   
%  Usage:  product = maskSumtBecq(ecat_filename, mask_filename, arterial_filename) 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.5.0.197613 (R2015a) 
%% $Id$ 

PIE = 4.88;
FRAMELENGTH = 300;

import mlpet.* mlfourd.*;
assert(lexist(ecatfn, 'file'));
assert(lexist(maskfn, 'file'));
assert(lexist( artfn, 'file'));

mask = NIfTId.load(maskfn);

if (lstrfind(ecatfn, 'oc'))
    ecat = NIfTId.load(ecatfn);
    ecatwc = ecat.clone;
    ecatwc.img = ecatwc.img * PIE * FRAMELENGTH;
    final = MaskingNIfTId(ecatwc, 'binary_mask', mask);
else
    ecat = mlsiemens.DecayCorrectedEcat.load(ecatfn);
    ecatwc = ecat.component; 
    ecatwc.img = ecat.counts * ecat.pie; % becquerels * taus
    dynob = DynamicNIfTId(ecatwc, 'timeSum', true);
    final = MaskingNIfTId(dynob,  'binary_mask', mask);
end

if (lstrfind(artfn, '.dta'))
    arterial = DTA.load(artfn);
elseif (lstrfind(artfn, '.crv'))
    arterial = CRV.load(artfn);
end
arterialIntegral = 0;
for t = 1:arterial.length
    arterialIntegral = arterialIntegral + arterial.wellCounts(t)*arterial.taus(t);
end

finalVol = prod(final.mmppix)/1000; % mL
fprintf('\n');
fprintf('finalVol -> %g, arterialIntegral -> %g\n', finalVol, arterialIntegral);
final.img = final.img / finalVol / arterialIntegral;
final.fileprefix = [ecat.fileprefix '_maskSumtBecq'];
final.filepath = ecat.filepath;



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/temp.m] ======  

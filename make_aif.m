function aif_msk_sum = make_aif(ep2d, aif_msk)

import mlfourd.*;
assert(ischar(ep2d));
assert(ischar(aif_msk));
ep2d      = NIfTI.load(ep2d);
aif_msk   = NIfTI_mask.load(aif_msk);
aif_msk_x = ep2d .* aif_msk;
aif_msk_x.fqfn
sz = aif_msk_x.size;
fprintf('%s (x) %s:  size(...)->[%i %i %i %i], sum(%s)->%g\n', ... 
         ep2d.fileprefix, aif_msk.fileprefix, sz(1), sz(2), sz(3), sz(4), aif_msk.fileprefix, aif_msk.dipsum);
assert(aif_msk.dipsum > 0);

aif_msk_sum = aif_msk_x;
tmp = aif_msk_x.img;
tmp = sum(tmp,1);
tmp = sum(tmp,2);
tmp = sum(tmp,3);
tmp = squeeze(tmp);
assert(length(tmp) == sz(4));
aif_msk_sum.img = tmp / aif_msk.dipsum;
aif_msk_sum.fileprefix = [aif_msk.fileprefix '_mean'];
aif_msk_sum.save;
plot(aif_msk_sum.img);
title(aif_msk_sum.fileprefix, 'FontSize', 16);
fprintf('mean(%s) formatted for c#:\n', aif_msk_sum.fileprefix);
fprintf('{ ');
for t = 1:length(aif_msk_sum.img)-1
    fprintf('%g, ', aif_msk_sum.img(t));
end
fprintf('%g', aif_msk_sum.img(end));
fprintf(' }\n');

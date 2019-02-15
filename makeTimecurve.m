%MAKETIMECURVE
%
%   Usage:  tcurve = makeTimecurve(map, imap, epi)
%
%           map    -> 3dfp dipimage to use for masking
%           imap   -> z-index
%           epi    -> 4dfp EPI data as dipimage
%           tcurve -> 1dfp dipimage

function tcurve = makeTimecurve(map, imap, epi)

threshold = 0.1*max(map);
map  = squeeze(map);
mask = map(:,:,imap) > threshold;

epiSizes = size(epi);
Nt = epiSizes(4);
tcurve = newim(Nt);

slice = newim(epiSizes(1), epiSizes(2));

for t = 0:Nt-1
    M = squeeze(mask);
    N = squeeze(epi(:,:,imap,t));
    slice = M.*N; % element-by-element
    tcurve(t) = double(sum(slice, [], [1 2]));
end
norm = squeeze(sum(mask, [], [1 2]))*Nt;
if (norm > 0)
    tcurve = tcurve/norm;
end


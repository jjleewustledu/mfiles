%NILIO_WRITEDIPCOLORIMAGE
%
%  USAGE:
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function [] = nilio_writeDipColorImage(colorim, filename)

reds   = double(colorim{1});
greens = double(colorim{2});
blues  = double(colorim{3});

sizeReds   = size(reds);
sizeGreens = size(greens);
sizeBlues  = size(blues);

tmpReds   = size(sizeReds);
tmpGreens = size(sizeGreens);
tmpBlues  = size(sizeBlues);

rankReds   = tmpReds(2);
rankGreens = tmpGreens(2);
rankBlues  = tmpBlues(2);

if (rankReds > 2)
    reds = reds(:,:,1);
end
if (rankGreens > 2)
    greens = greens(:,:,1);
end
if (rankBlues > 2)
    blues = blues(:,:,1);
end

sizes = size(reds);
newcolorim = zeros(sizes(1), sizes(2), 3);
newcolorim(:,:,1) = reds;
newcolorim(:,:,2) = greens;
newcolorim(:,:,3) = blues;

imwrite(newcolorim, colormap(copper), filename, 'png');

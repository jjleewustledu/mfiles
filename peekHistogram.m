%PEEKHISTOGRAM
%
% Usage:  [binLocs, counts] = peekHistogram(roi, img)
%         bar(binLocs, counts) plots the histogram
%__________________________________________________________________________

function [binLocs, counts, list] = peekHistogram(roi, img)

FASTER  = 1;
NUMBINS = 40;

roi = roi > 0; % convert to boolean
roi = double(scrubNaNs(squeeze(double(roi))));
img = double(scrubNaNs(squeeze(double(img))));

sizes = size(img);
N     = sum(sum(sum(roi)));
list  = zeros(N,1);

disp(['class of roi -> ' class(roi)]);
disp(['class of list -> ' class(list)]);
disp(['class of img -> ' class(img)]);

if (FASTER)
    list = reshape(roi .* img, prod(sizes), 1);
else
    i = 0;
    for z = 1:8
        for x = 1:256
            for y = 1:256
                i = i + 1;
                if (roi(x,y,z) > 0)
                    list(i,1) = img(x,y,z); 
                end
            end
        end
    end
    if N ~= i, error(['N was ' num2str(N) ' but i was ' num2str]); end
end

if (max(list) > 0)
    bins = 0.0:max(list)/NUMBINS:max(list);
else
    bins = -2:1:3;
end

[counts, binLocs] = hist(list, bins);




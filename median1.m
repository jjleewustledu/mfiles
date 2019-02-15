% MEDIAN modifies Matlab's median to behave like dip_image's median
function y = median1(x)
y = x;
while prod(size(y)) > 1
    y = median(x);
end
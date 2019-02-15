% MAX modifies Matlab's max to behave like dip_image's max
function y = max1(x)
y = x;
while prod(size(y)) > 1
    y = max(x);
end
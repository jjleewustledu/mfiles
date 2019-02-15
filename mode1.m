% MODE modifies Matlab's mode to behave like dip_image's mode
function y = mode1(x)
y = x;
while prod(size(y)) > 1
    y = mode(x);
end
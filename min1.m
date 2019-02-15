% MIN modifies Matlab's min to behave like dip_image's min
function y = min1(x)
y = x;
while prod(size(y)) > 1
    y = min(x);
end
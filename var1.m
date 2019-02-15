% VAR modifies Matlab's var to behave like dip_image's var
function y = var1(x)
y = x;
while prod(size(y)) > 1
    y = var(x);
end
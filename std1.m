% STD modifies Matlab's std to behave like dip_image's std
function y = std1(x)
y = x;
while prod(size(y)) > 1
    y = std(x);
end
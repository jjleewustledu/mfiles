% MEAN modifies Matlab's mean to behave like dip_image's mean
function y = mean1(x)
y = x;
while prod(size(y)) > 1
    y = mean(x);
end
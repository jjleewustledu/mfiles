
%% INDEXOFMIN finds the index of the min value of a 1D array
%  Usage:  idx = indexOfMin(arr)
function   idx = indexOfMin(arr)

globalmin = realmax;
idx       = 0;
for i = 1:length(arr)
    if (arr(i) < globalmin)
        globalmin = arr(i);
        idx = i;
    end
end
end % function indexOfMin
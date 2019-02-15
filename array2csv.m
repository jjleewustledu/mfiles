function array2csv(arr)

assert(isnumeric(arr));
arr = squeeze(arr);
fprintf('Numeric array formatted for c#:\n');
fprintf('{ ');
for t = 1:length(arr)-1
    fprintf('%g, ', arr(t));
end
fprintf('%g', arr(end));
fprintf(' }\n');

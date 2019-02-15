%PIDCOUNT

function count = pidCount(measurementType)

count = 0;
for i = 1:pidList()
    if ~pidToExclude(i), count = count + 1; end
end

%COMPACTARRAY
%
%   usage:  [compact, keepers] = compactArray(theArr, toKeep, lowLim, upLim, keepers0)
%
%           theArr - double array with empty, NaN or out-of-bounds elements
%           toKeep - logical array same size as theArr
%           lowLim - optional - lower bound
%           upLim  - optional - upper bound
%__________________________________________________________________________

function [compact, keepers] = compactArray(theArr, toKeep, lowLim, upLim)

switch (nargin)
    case 1
        toKeep = ones(size(theArr,1), 1);   
        lowLim = eps;
        upLim  = realmax;
    case 2
        lowLim = eps;
        upLim  = realmax;
    case 3
        upLim  = realmax;
    case 4
    otherwise
        error(help('compactArray'));
end

if ~isnumeric(theArr),
    error(['compactArray:  theArr must be a double, matlab array']); end
if (prod(size(theArr)) <= 1) 
    compact = 0; 
    keepers = 0;
    return;
end
theArr = scrubNaNs(theArr, 1); % returns double column vector

disp(['compactArray:  numel(toKeep)                            -> ' num2str(numel(toKeep))]);
disp(['compactArray:  sum(toKeep)                              -> ' num2str(sum(toKeep))]);
disp(['compactArray:  numel(theArr)                            -> ' num2str(numel(theArr))]);
disp(['compactArray:  sum(theArr >= lowLim && theArr <= upLim) -> ' num2str(sum((theArr >= lowLim) && (theArr <= upLim)))]);
if (sum(toKeep) < numel(theArr))  
    keepers = toKeep  & (theArr >= lowLim);
    keepers = keepers & (theArr <= upLim);  
else
    keepers = toKeep;
end

compact = zeros(sum(keepers),1);
disp(['numel(compact)                           -> ' num2str(numel(compact))]);

j = 0;
ne = numel(theArr);
disp(['numel(theArr) -> ' num2str(numel(theArr))]);
for i = 1:size(keepers,1)
    if (keepers(i) && i < ne)
        j = j + 1;
        compact(j) = theArr(i); 
    end
end



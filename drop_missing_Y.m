function [X2,Y2] = drop_missing_Y(X,Y)

%
% S. HSIANG
% SMH2137@COLUMBIA.EDU
% 5/10
%
% ----------------------------
%
% [X2, Y2] = drop_missing_Y(X,Y)
%
% Takes the matrices X and Y and drops any rows that contain at least one 
% entry that is coded "missing" with NaN in either matrix. X and Y must
% have the same number of rows, but need not have the same number of
% columns. For use with multivariate regression.
% In the above command, X2 and Y2 will contain no missing observations, so
% Y2 can be regressed on X2 if Y2 is a vector (has only one column).
%

if length(X) ~= length(Y)
    disp('SOL: X and Y must have the same number of observations')
    X2 = false;
    Y2 = false;
    return
end

r = size(Y,2);

X = [X,Y];

rows = (max(isnan(X),[],2)==0);

Q = X(rows,:);

Y2 = Q(:,end-r+1:end);
X2 = Q(:,1:end-r);

return





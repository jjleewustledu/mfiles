% CONVERTF_SINGLEPATIENT
%
% Usage:    cbf = convertF_singlepatient(F, intag, outtag, cfun)
%
%           F:       matlab cell array
%           intag:  'ho1', 'bayesF', 'F', 'mlemF', mlemRefF'
%           outtag: 'ho1', 'bayesF', 'F', 'mlemF', mlemRefF'
%           cfun:    when present, will override any internal cfit objects
%           cbf:     matlab double column vector
%           ninfo:   array filled with integer values for each roi type
%

function [cbf, ninfo] = convertF_singlepatient(F, intag, outtag, cfun)

switch (nargin)
    case 1 
        cfun   = 0;
        intag  = 'bayesF';
    case 2
        cfun   = 0;
    case 3
    otherwise
        error(help('convertF_singlepatient'));        
end
imgidx = -1;
switch (intag)
    case {'ho1', 'CBF'}
        imgidx = 1;
    case {'bayesF', 'F'}
        imgidx = 2;
    case 'mlemF'
        imgidx = 3;
    case 'mlemRefF'
        imgidx = 4;
    otherwise
        error(['convertF_singlepatient:  could not recognize ' intag]);
end

% roi type
lenx = 0;
for j = 1:size(F,2)
    % side
    for k = 1:size(F,3)
        maxm  = size(F{imgidx,j,k});           
        lenx = lenx + (j-1)*size(F,2)*size(F,3)*maxm + (k-1)*size(F,3)*maxm + maxm;           
    end
end
leny  = lenx;
x     = zeros(lenx); % allocating for speed-up
y     = zeros(leny);
ninfo = zeros(lenx);
i     = 0;
% roi type
for j = 1:size(F,2)
    % side
    for k = 1:size(F,3)
        maxm  = size(F{imgidx,j,k});
        if (1 == imgidx) % magic index for ho1 data            
            for m = 1:maxm
                i        = (j-1)*size(F,2)*size(F,3)*maxm + (k-1)*size(F,3)*maxm + m;
                x(i)     = F{imgidx,j,k}(m);
                ninfo(i) = j;
            end
        else
            for m = 1:maxm
                i    = (j-1)*size(F,2)*size(F,3)*maxm + (k-1)*size(F,3)*maxm + m;
                y(i) = F{imgidx,j,k}(m);
            end
        end            
    end
end

try
    all = x > eps & y > eps & isnumeric(x) & isnumeric(y);
catch
    try
        x = scrubNaNs(x); y = scrubNaNs(y);
        all = x > eps & y > eps & isnumeric(x) & isnumeric(y);
    catch
        error('convertF_singlepatient:  could not form x, y, all');
    end
end
x_all = compactArray(x, all);
y_all = compactArray(y, all);
if (~isnumeric(x) | ~isnumeric(y))
    cbf = 0;
    return;
end

if (4 == imgidx | strcmp(intag, outtag) | ...
    prod(size(x_all)) < 2 | prod(size(y_all < 2))) % do no additional rescaling
    cbf = y_all;
    return;
end
[cfun, gof, fitout] = fit(x_all, y_all, 'poly1')
cbf = (y_all - cfun.p2*ones(size(y_all,1),1))./cfun.p1;



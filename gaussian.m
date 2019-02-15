%GAUSSIAN
%
% Usage:    y = gaussian(X, mu, sigma)
%
%           X     -> multiplet coord as row, 
%                    e.g., [3.1 4 6.2], (0:0.01:1)'
%                    or matrix coord; each point has a multiplet-coord row
%           mu    -> multiplet means as row,
%                    e.g., [mean_x mean_y mean_z]
%           sigma -> multiplet standard deviations as row
%                    e.g., [std_x std_y std_z]
%           y     -> col of same height as X
%

function y = gaussian(X, mu, sigma)

    USE_NORMPDF = 1; % optimized

    if [1 2]   ~= size(size(X)), error(help('gaussian')); end
    npts = size(X,1);
    dim  = size(X,2);
    if [1 dim] ~= size(mu),      error(help('gaussian')); end
    if [1 dim] ~= size(sigma),   error(help('gaussian')); end
    
    if (USE_NORMPDF)
        Ones = ones(npts, 1);
        y    = Ones;
        for d = 1:dim
            if (sigma(d) > eps)
                y = y .* normpdf(X(:,d), mu(d), sigma(d)); end
        end
    else
        % pedagogical & cross-checking code
        % row * row' -> inner product
        % col * row  -> outer product
        Arg2 = ones(npts,1);
        for i = 1:npts
            Arg2(i) = ((X(i,:) - mu)./(sqrt(2)*sigma)) * ((X(i,:) - mu)./(sqrt(2)*sigma))';
        end
        prodSigmas = 1;
        for p = 1:dim
            if (sigma(p) > eps)
                prodSigmas = prodSigmas * sigma(p); end
        end
        y = exp(-Arg2)/(sqrt(2*pi)^dim*prodSigmas);
    end

    if [npts 1] ~= size(y), error(['oops...  size(y) was ' num2str(size(y))]); end


%
% Usage:    fwhh = sigma2fwhh(sigma, mmppix)
%
%           sigma  -> vector of sigma/pixels
%           mmppix -> optional vector to convert sigma/pixels to fwhh/mm;
%                     otherwise units are preserved
%           fwhh   -> vector of fwhh/mm
%
%           embedded in R^3
%____________________________________________________

function fwhh = sigma2fwhh(sigma, mmppix)

    % a1/2 = a1*exp(-((x-b1)/c1)^2);
    % -log(2) = -((x - b1)/c1)^2
    % c1^2 = 2*sigma^2;
    % log(2)*2*sigma^2 = (x - b1)^2
    % sqrt(log(2)*2*sigma^2) = x - b1 = fwhh/2

    dim = max([size(sigma,2) size(sigma',2)]);
    switch (nargin)
        case 1
            sigma = embedInVector(sigma, dim);
        case 2 
            sigma = embedInVector(sigma, dim) .* embedInVector(mmppix, dim);
        otherwise
            error(help('sigma2fwhh'));
    end  
    fwhh = 2*sqrt(log(2)*2*sigma.^2);

   

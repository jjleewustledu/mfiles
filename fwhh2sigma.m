%FWHH2SIGMA
%
% Usage:    sigma = fwhh2sigma(fwhh, mmppix)
%
%           sigma  -> vector of sigma/pixels
%           mmppix -> optional vector to convert fwhh/mm to sigma/pixels;
%                     otherwise units are preserved
%           fwhh   -> vector of fwhh/mm
%____________________________________________________

function sigma = fwhh2sigma(fwhh, mmppix)

% a1/2 = a1*exp(-((x-b1)/c1)^2);
% -log(2) = -((x - b1)/c1)^2
% c1^2 = 2*sigma^2;
% log(2)*2*sigma^2 = (x - b1)^2
% sqrt(log(2)*2*sigma^2) = x - b1 = fwhh/2
% 
 
dim = max([size(fwhh,2) size(fwhh',2)]);
switch (nargin)
    case 1
        fwhh = embedInVector(fwhh, dim);
    case 2 
        fwhh = embedInVector(fwhh, dim) ./ embedInVector(mmppix, dim);
    otherwise
        error(help('fwhh2sigma'));
end        
sigma = abs(sqrt((fwhh/2).^2/(2*log(2))));  

%GAUSS3D
%
% Usage:    y = gauss3d(x, mu, sigma)
%
%           x     -> triplet coord, e.g., [3.1 4 6.2]
%           mu    -> triplet means
%           sigma -> triplet stand. dev.
%

function y = gauss3d(x, mu, sigma)

if ~([3 1] == size(x),     error(help('gauss3d')); end
if ~([3 1] == size(mu),    error(help('gauss3d')); end
if ~([3 1] == size(sigma), error(help('gauss3d')); end

y = exp(-(x - mu).^2/(sqrt(2*pi)^3*sigma(1)*sigma(2)*sigma(3));

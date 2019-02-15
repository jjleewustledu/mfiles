function [ I, Hxy, Hyx, Hx, Hy, H, msg ] = mutualinfo(x, y, verbosity)
%% MUTUALINFO estimates the mutualinformation between arrays x, y
%  Usage:  [ I Hxy Hyx Hx Hy H ] = mutualinfo(x, y, verbosity)
%            ^ mutual information                   
%              ^   ^ conditional entropies H(x|y), H(y|x) 
%                      ^  ^ entropies H(x), H(y)
%                            ^ entropy H(x, y)
%  x, y may be mlfourd.NIfTI
%  verbosity in [0..1], default 0

TOL = 1;
if (nargin < 3); verbosity = 0; end
if (isa(x, 'mlfourd.INIfTI')); x = x.img; end
if (isa(y, 'mlfourd.INIfTI')); y = y.img; end

H   = entropy(x .* y);
Hx  = entropy(x);
Hy  = entropy(y);
Hxy = H - Hy;
Hyx = H - Hx;
I   = Hx - Hxy;
assert(abs(I - Hy + Hyx) < TOL*I, ['Hx - Hxy -> ' num2str(I) ' but Hy - Hyx -> ' num2str(Hy - Hyx)]);
msg = sprintf('mutualinfo:  I->%g, H(x,y)->%g, H(x|y)->%g, H(y|x)->%g, H(x)->%g, H(y)->%g', I, H, Hxy, Hyx, Hx, Hy);
if (verbosity > 0);
    fprintf(1, 'mutualinfo:  I->%g, H(x,y)->%g, H(x)->%g, H(y)->%g', I, H, Hx, Hy); end
if (verbosity > 0.5);
    disp(msg); end


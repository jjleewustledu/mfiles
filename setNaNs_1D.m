%SETNANS_1D
%
% Usage:  outvec = setNaNs_1D(invec, retDble)
%
%                  invec   -> reasonably formed dipimage
%                  outvec  -> column vector dipimage
%                  retDble -> return matlab column array?  1 or 0.
%

function outvec = setNaNs_1D(invec, retDble)

THRESH = 0;
disp(['setNaNs_1D will set all elements of the input < ' THRESH ' to NaN']);

invec = squeeze(invec);
sizes = size(invec);
N     = sizes(1);
if ~(N > 1),
    error(['setNaNs_1D:  Oops...  N -> ' num2str(N)]); end 
for j = 0:N-1
    if double(invec(j)) < THRESH, invec(j) = NaN; end
end

if 2 ==nargin && retDble, outvec = double(invec)';
else outvec = dip_image(invec); end


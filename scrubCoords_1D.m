%SCRUBCOORDS_1D
%
% Usage:  outvec = scrubCoords_1D(invec, retDble)
%
%                  invec   -> reasonably formed dipimage
%                  outvec  -> column vector dipimage
%                  retDble -> return matlab column array?  1 or 0.
%

function coords = scrubCoords_1D(invec, thresh)

invec  = squeeze(double(scrubNaNs(invec))');
sizes  = size(invec);
N      = sizes(1);
if ~(N > 1), error(['scrubCoords_1D:  Oops...  N -> ' num2str(N)]); end 
h      = 0;

for i = 1:N
    if (invec(i) < thresh)
        h = h + 1;
    else        
        coords{i-h} = invec(i);
    end
end

disp(['scrubCoords_1D processed ' num2str(i) ' elements:  ' ...
      num2str(i-h) ' > thresh and ' num2str(h) ' < thresh; thresh -> ' num2str(thresh)]);

coords = cell2mat(coords)';



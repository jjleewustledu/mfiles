%PEEKSCATTERPIDS
%
%  SYNOPSIS:  peekScatterPids(x, y, itsTitle)
%             peekScatterPids(x, y, itsTitle, colorString)
%
%         x:           matlab array or dipimage object of abscissa data values
%         y:           matlab array or dipimage object of ordinate data values
%         itsTitle:    string
%         colorString: e.g., left lesion -> 'rrrrrrbbbbbb', right lesion -> 'bbbbbbrrrrrr'
%
%  SEE ALSO:  gscatter, myscatter
%
% $Id$
%
function peekScatterPids(x, y, itsTitle, varargin)

if size(x,1) ~= NPIDS*NROIS*NSIDES,
  error('unexpected number of abscissa values');
end
if size(y,1) ~= NPIDS*NROIS*NSIDES,
  error('unexpected number of ordinate values');
end

% convert to matlab arrays if needed
if (isa(x, 'dip_image')) x = double(x); end
if (isa(y, 'dip_image')) y = double(y); end
        


group_byregion = {  
    'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; ...
    'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; ...
    'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; ...
    'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia'; 'basal ganglia';...
    'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; ...
    };

colors = 'kkkkkkkkkkkkkkkkkkkbbbbbbbbbbbbbbbbbbbccccccccccccccccccc';

%%%symbols = 'ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo'; 

%%%sizes = [ 5; 5; 5; 5; 5; 5; 5 ]; 

gscatter(x, y, group_byregion, colors) %%% , symbols, sizes, 'on', 'PET CBF/(mL/100g/min)', 'Bayesian <F>/(arbitrary)')
title(itsTitle, 'FontSize', 12)

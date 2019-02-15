%PEEKSCATTERSIDES
%
%  SYNOPSIS:  peekScatterSides(x, y, itsTitle)
%             peekScatterSides(x, y, itsTitle, colorString)
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
function peekScatterSides(x, y, itsTitle, xlabel, ylabel)

x = scrubNaNs(x);
y = scrubNaNs(y);
if (isa(x, 'dip_image')) x = double(x)'; end
if (isa(y, 'dip_image')) y = double(y)'; end

if size(y,1) ~= size(x,1), 
    error(['Oops...  len y -> ' num2str(size(y,1)) ' but len x -> ' num2str(size(x,1)) ...
           '; x and y must be the same length for use by scatter functions']); end
N      = size(y,1);
NPIDS  = 19;
NROIS  = 3;
NSIDES = 2;
        


group_byregion = {  
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra'; ...
    'ipsi'; 'contra'; 'ipsi'; 'contra'; 'ipsi'; 'contra' };

colors  = 'brbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbrbr';

symbols = 'oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo'; 

sizes   = [ 
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5; ...
    5; 5; 5; 5; 5; 5  ]; 

if nargin < 3,
    itsTitle = 'TITLE'; end
if nargin < 4,
    xlabel = 'X'; end
if nargin < 5,
    ylabel = 'Y'; end

if NROIS > 1, dolegend = 'on'; 
else          dolegend = 'off'; end

gscatter(x, y, group_byregion, colors , symbols, sizes, dolegend, xlabel, ylabel)
title(itsTitle, 'FontSize', 16, 'FontWeight', 'demi')

%ROIS_SCATTER plots results from the rois_skeleton C# solution
%
%  SYNOPSIS:  rois_scatter(x, y, itsTitle)
%             rois_scatter(x, y, itsTitle, colorString)
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
function rois_scatter(x, y, itsTitle, varargin)

% convert to matlab arrays
if (isa(x, 'dip_image')) x = double(x); end
if (isa(y, 'dip_image')) y = double(y); end
        
group_byregion = { 'L hemisphere'; 'L grey mca'; 'L grey aca'; 'L grey pca'; 'L white mca';                'L white pca'; 'L putamen'; 'L thalamus'; ...
                   'R hemisphere'; 'R grey mca'; 'R grey aca'; 'R grey pca'; 'R white mca'; 'R white aca'; 'R white pca'; 'R putamen'; 'R thalamus'  };

colors6 = 'kbcymr';

colors2 = 'rrrrrrrrbbbbbbbbb';
if (length(varargin) > 0) colors2 = varargin{1}; end

colors3 = 'rgb';

symbols = 's^^^vv+os^^^vvv+o';

sizes = [ 15; 20; 10; 15; 20;     15; 15; 15; 15; 20; 10; 15; 20; 10; 15; 15; 15 ];
%%disp(['size of sizes = ' num2str(size(sizes))])

scrsz = get(0,'ScreenSize');
fracscr = 0.47;
figure('Position',[32 64 fracscr*scrsz(3) fracscr*scrsz(4)])

gscatter(x, y, group_byregion, colors2, symbols, sizes, 'on', 'MR CBF/arbitrary', 'PET CBF/(mL/100g/min)')
title(itsTitle, 'FontSize', 18)
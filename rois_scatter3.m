%ROIS_SCATTER3 plots results from the rois_skeleton C# solution
%
%  SYNOPSIS:  rois_scatter3(csvfile, atitle, (opt) intercept, (opt) slope)
%   csvfile:  fully qualified filename of comma-separated floating-point
%             data; string
%   atitle:   string
%   (optional) intercept, slope
%
%  SEE ALSO:  rois_scatter, gscatter, myscatter
%
%  $Id$
%________________________________________________________________________
function rois_scatter3(csvfile, atitle, varargin)

disp('>>>>> reading csv-file ->'); csvfile
csv  = csvread(csvfile, 1, 1, 'B2..P80');
NROIs = 79;
goldStd = zeros(NROIs,1);
newMeth = zeros(NROIs,1);
newMeth = csv(:,7);
goldStd = csv(:,2);

rois_scatter(goldStd, newMeth, atitle)

if (length(varargin) > 0)
    intercept = varargin{1};
    slope     = varargin{2};
    %%hold on
    %%incr = (max(goldStd) - min(goldStd))/100;
    %%x0   = 0:incr:max(goldStd);
    %%y0   = intercept + slope*x0;
    %%plot(x0, y0, '-k', 'LineWidth', 1)
    %%hold off
    %%disp('fitted line was drawn');

    buff = 0.1;
    shortx0 = (max(newMeth) - min(newMeth))/8 + buff;
    shorty0 = intercept + slope*shortx0;
    %%text(shortx0, shorty0, ['\leftarrow Bayes <F> = ' num2str(intercept,3) ' + ' num2str(slope,3) ' * PET CBF'])
    %%disp('text annotation was drawn');
end
    

    


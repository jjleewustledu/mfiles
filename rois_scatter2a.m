%ROIS_SCATTER2 plots results from the rois_skeleton C# solution
%
%  SYNOPSIS:  rois_scatter2(csvfile, atitle, NOIs, (opt) intercept, (opt) slope)
%   csvfile:  fully qualified filename of comma-separated floating-point
%             data; string
%   atitle:   string
%   (optional) intercept, slope
%
%  SEE ALSO:  rois_scatter, gscatter, myscatter
%
%  $Id$
%
function rois_scatter2a(csvfile, atitle, NROIs, varargin)

csv  = csvread(csvfile, 0, 1, [0 1 (NROIs-1) 2]);
disp('>>>>> csv ->');
csv
gold = zeros(NROIs,1);
mr   = zeros(NROIs,1);
mr   = csv(:,1);
gold = csv(:,2);

rois_scatter(gold, mr, atitle)

if (length(varargin) > 0)
    intercept = varargin{1};
    slope     = varargin{2};
else
    intercept = 0;
    slope = 1;
end
    
%%hold on
%%incr = (max(gold) - min(gold))/100;
%%x0   = 0:incr:max(gold);
%%y0   = intercept + slope*x0;
%%plot(x0, y0, '-k', 'LineWidth', 1)
%%hold off
%%disp('fitted line was drawn');

buff = 0.1;
shortx0 = (max(mr) - min(mr))/8 + buff;
shorty0 = intercept + slope*shortx0;
%%text(shortx0, shorty0, ['\leftarrow Bayes <F> = ' num2str(intercept,3) ' + ' num2str(slope,3) ' * PET CBF'])
%%disp('text annotation was drawn');
    


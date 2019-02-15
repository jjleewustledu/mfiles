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
function rois_scatter2(csvfile, atitle, NROIs, varargin)

csv = csvread(csvfile, 0, 0, [0 0 (NROIs-1) 1]);
mlem = zeros(NROIs,1);
mr  = zeros(NROIs,1);
mlem = csv(:,1);
mr  = csv(:,2);

% convert MR arbitrary values to mL/min/100cc
mrCoef01 = 0.627;
mrCoef11 = 9.43;
mr = mrCoef01 + mrCoef11*mr;

mlemCoef01 = 4.5441;
mlemCoef11 = 11831.8237;
mlem = mlemCoef01 + mlemCoef11*mlem;


rois_scatter(mlem, mr, atitle)

if (length(varargin) > 0)
    intercept = varargin{1};
    slope     = varargin{2};
else
    intercept = 0;
    slope = 1;
end
    
hold on
incr = (max(mr) - min(mr))/100;
x0   = 0:incr:max(mr);
y0   = intercept + slope*x0;
plot(x0, y0, '-k', 'LineWidth', 1)
hold off
disp('fitted line was drawn');

buff = 0.1;
shortx0 = (max(mr) - min(mr))/8 + buff;
shorty0 = intercept + slope*shortx0;
text(shortx0, shorty0, ['\leftarrow PET CBF = ' num2str(intercept,3) ' + ' num2str(slope,3) ' * MR CBF'])
disp('text annotation was drawn');
    


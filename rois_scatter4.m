%ROIS_SCATTER4 plots x -> y with errorbars for both
%
%  SYNOPSIS:  rois_scatter4(csvfile, atitle, (opt) intercept, (opt) slope)
%   csvfile:  fully qualified filename of comma-separated floating-point
%             data; string
%   atitle:   string
%   (optional) intercept, slope
%
%  SEE ALSO:  rois_scatter, gscatter, myscatter
%
%  $Id$
%________________________________________________________________________
function rois_scatter4(csvfile, atitle, varargin)

disp('>>>>> reading csv-file ->'); csvfile
csv  = csvread(csvfile, 1, 14, 'O2..V51');
NROIs = 50;
xall     = zeros(NROIs,1);
yall     = zeros(NROIs,1);
err_xall = zeros(NROIs,1);
err_yall = zeros(NROIs,1);
xall     = csv(:,5);
yall     = csv(:,6);
err_xall = csv(:,7);
err_yall = csv(:,8);

% colors:  rgbcmyk

x  =     xall(1:9);   % caudate
y  =     yall(1:9);
ex = err_xall(1:9);
ey = err_yall(1:9);
errorbar(x, y, ey, 'or')
hold on
herrorbar(x, y, ex, 'or')

x  =     xall(10);    % cerebellum
y  =     yall(10);
ex = err_xall(10);
ey = err_yall(10);
errorbar(x, y, ey, 'og')
herrorbar(x, y, ex, 'og')

x  =     xall(11:21); % grey
y  =     yall(11:21);
ex = err_xall(11:21);
ey = err_yall(11:21);
errorbar(x, y, ey, 'ob')
herrorbar(x, y, ex, 'ob')

x  =     xall(22:25); % hippocampus
y  =     yall(22:25); 
ex = err_xall(22:25); 
ey = err_yall(22:25); 
errorbar(x, y, ey, 'oc')
herrorbar(x, y, ex, 'oc')

x  =     xall(26:33); % putamen
y  =     yall(26:33);
ex = err_xall(26:33);
ey = err_yall(26:33);
errorbar(x, y, ey, 'om')
herrorbar(x, y, ex, 'om')

x  =     xall(34:40); % thalamus
y  =     yall(34:40);
ex = err_xall(34:40);
ey = err_yall(34:40);
errorbar(x, y, ey, 'oy')
herrorbar(x, y, ex, 'oy')

x  =     xall(41:50); % white
y  =     yall(41:50);
ex = err_xall(41:50);
ey = err_yall(41:50);
errorbar(x, y, ey, 'ok')
herrorbar(x, y, ex, 'ok')
hold off

%%h = legend('caudate','cerebellum','grey','hippocampus','putamen','thalamus','white');
%%set(h,'Interpreter','none')

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
    

    


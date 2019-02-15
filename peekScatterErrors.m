%PEEKSCATTERERRORS plots x -> y with errorbars for both
%
%  SYNOPSIS:  peekScatterErrors(xall, yall, err_xall, err_yall, varargin)
%   csvfile:  fully qualified filename of comma-separated floating-point
%             data; string
%   atitle:   string
%   (optional) intercept, slope
%
%  SEE ALSO:  rois_scatter, gscatter, myscatter
%
%  $Id$
%________________________________________________________________________
function peekScatterErrors(xall, yall, err_xall, err_yall, varargin)

errorbar(xall, yall, err_yall, err_yall, '.b')
hold on
herrorbar(xall, yall, err_xall, err_xall,  '.b')


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
    

    


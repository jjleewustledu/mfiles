%  PUBLISHPLOT
%
%   Usage:  [h, pfout, x_all, y_all, all, info] = publishPlot(ho1Cbf, mrArb, anxlabel, aylabel, shortxlabel, shortylabel)
%
%           ho1Cbf is a column vector with PET CBF values
%           mrArb  is a column vector with MR perfusion numbers (arbitrary
%                  units)
%           anxlabel, aylabel are axis labels for the plot
%           shortxlabel, shortylabel are used for generating filenames if
%                                    the script parameter SAVE_TO_DISK is set to true
%           
%           Please check that script parameters in all caps are appropriate for
%           your system.  
%
%   See also: polyfit, polyconf, zscore 
%             help for predint :: Functions(Curve Fitting Toolbox)
%             bootstrap conf. int.
%

function [h, pfout, x_all, y_all, all] = publishPlot(ho1Cbf, mrArb, anxlabel, aylabel, shortxlabel, shortylabel)

HOME = '/home/jjlee/';
SAVE_TO_DISK = 1;
DPI = 1200; % publication quality color postscript
DINGBAT_SIZE = 10;
PLOT_POSITION = [1 1 600 600];
TIGHTINSET = [64 64 64 64];

cd(HOME)
load('extra_tag3.mat'); % unexplained bad data points

info = peekInfo('allrois', 'ho1', 'both', 1, 0);

all = ho1Cbf > eps & extra_tag; % most selective filter for all imaging data, typically 'ho1'
greys  = all & strcmp(info(:,3), 'grey');
basals = all & strcmp(info(:,3), 'basal');
whites = all & strcmp(info(:,3), 'white');

x_all   = compactArray(ho1Cbf, all,    0, realmax);
y_all   = compactArray(mrArb,  all,    0, realmax);
x_grey  = compactArray(ho1Cbf, greys,  0, realmax);
y_grey  = compactArray(mrArb,  greys,  0, realmax);
x_basal = compactArray(ho1Cbf, basals, 0, realmax);
y_basal = compactArray(mrArb,  basals, 0, realmax);
x_white = compactArray(ho1Cbf, whites, 0, realmax);
y_white = compactArray(mrArb,  whites, 0, realmax);
x_fit   = 0:1:max(ho1Cbf);
disp('[x_all y_all');
[x_all y_all]

[zx_all, zx_mu, zx_sigma] = zscore(x_all);
[zy_all, zy_mu, zy_sigma] = zscore(y_all);
zx_mu
zx_sigma
zy_mu
zy_sigma


%%%%%%%%%%%%%%%%%%%%%%%% USING THE POLYFIT METHOD %%%%%%%%%%%%%%%%%%%%%%%%

[p, S, mu] = polyfit(x_all, y_all, 1);
pfout.p = p;
pfout.S = S;
pfout.mu = mu(1);
pfout.sigma = mu(2);
pfout.R = S.R;         % triangular factor from QR-decomp. of Vandermonde of x_all
pfout.df = S.df;       % degrees of freedom
pfout.normr = S.normr; % norm of residuals
Rinv = pinv(S.R);
pfout.cov = (Rinv*Rinv')*(S.normr)^2/S.df;
pfout.fitted = polyval(p, x_fit, S, mu);
%%%[x_all y_all pfout.fitted y_all-pfout.fitted]

[confY, deltaY] = polyconf(p, x_all, S, 'mu', mu, 'predopt', 'curve', 'simopt', 'on');
disp('polynomial confidence intervals for the fitted curve, not confidence in observations of new ordinate measurements');
pfout.confY = confY;
pfout.deltaY = deltaY;
pfout.upperConf = confY + deltaY;
pfout.lowerConf = confY - deltaY;


%%%%%%%%%%%%%%%%%%%%%%%% USING THE FIT METHOD %%%%%%%%%%%%%%%%%%%%%%%%

[pfout.cfun, pfout.gof, pfout.fitout] = fit(x_all, y_all, 'poly1');
pfout.ci = confint(pfout.cfun, 0.95);
pfout.pi = predint(pfout.cfun, x_fit, 0.95, 'functional', 'on');


%%%%%%%%%%%%%%%%%%%%%%%% PLOT VISUALS %%%%%%%%%%%%%%%%%%%%%%%%

h = plot(x_grey, y_grey,  'ko ', 'MarkerSize', DINGBAT_SIZE);
    hold all;
    plot(x_basal,y_basal, 'kd ', 'MarkerSize', DINGBAT_SIZE);
    plot(x_white,y_white, 'ks ', 'MarkerSize', DINGBAT_SIZE);
    plot(x_fit,  pfout.fitted, 'k -'); 
    plot(x_fit,  pfout.pi,     'k--');
    %plot(x_fit,  pfout.upperConf,'k :');
    %plot(x_fit,  pfout.lowerConf,'k :');
set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
%set(gca, 'TightInset', TIGHTINSET); % TightInset is Read-only!
xlim([0 1.1*max(ho1Cbf)]);
ylim([0 1.1*max(mrArb)]);
xlabel(anxlabel, 'FontSize',16);
ylabel(aylabel,  'FontSize',16);
axis square;

legendStrings = {'grey matter', 'basal ganglia', 'white matter', 'least-squares fit', '95% c.i. of fit', ' '};
hl = legend(legendStrings, 'FontSize', 12, 'Location', 'Northwest'); % 'NorthWest'
legend('boxoff');

set(gcf, 'Color', 'white');
set(gcf, 'Position', PLOT_POSITION);
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [5.5 5.5]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 5.5 5.5]);
set(gcf, 'renderer', 'painters');
hold off;


%%%%%%%%%%%%%%%%%%%%%%%% ARCHIVE RESULTS %%%%%%%%%%%%%%%%%%%%%%%%

if (SAVE_TO_DISK)
    plotname = [shortxlabel '_to_' shortylabel '_scatter']
    hgsave(h, [HOME plotname '.fig'], 'all')
    print(gcf, '-depsc2', '-cmyk', ['-r' num2str(DPI)], [HOME plotname '.eps']) % '-tiff', 
    % print(gcf, '-dpng',                                 [HOME plotname '.png'])
end

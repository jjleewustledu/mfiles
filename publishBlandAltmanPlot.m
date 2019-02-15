%  PUBLISHBLANDALTMANPLOT
%
%   Usage:  [h, spanx] = publishBlandAltmanPlot(petCbf, mrArb, mrType, anxlabel, aylabel, shortxlabel, shortylabel)
%
%   See also:  help for predint :: Functions(Curve Fitting Toolbox)
%

function [h, spanx] = publishBlandAltmanPlot(petArb, mrArb, mrType, anxlabel, aylabel, shortxlabel, shortylabel)

HOME         = '/home/jjlee/';
SAVE_TO_DISK =  1;
DPI          =  1200; % publication quality color postscript
DINGBAT_SIZE = 10;
PLOT_POSITION = [1 1 600 600];
TIGHTINSET   = [64 64 64 64];
XMIN         =  0;
XMAX         =  100;
YMIN         = -75;
YMAX         =  75;
cd(HOME)
load('extra_tag.mat'); % unexplained bad data points

petCbf  = convertF(petArb, 'petCbf');
mrCbf   = convertF(mrArb,   mrType);
averCbf = (petCbf + mrCbf)/2;
diffCbf = mrCbf - averCbf;
disp(['size averCbf -> ' num2str(size(averCbf))]);
disp(['size diffCbf -> ' num2str(size(diffCbf))]);
disp(['size  petCbf -> ' num2str(size( petCbf))]);
disp(['size   mrCbf -> ' num2str(size(  mrCbf))]);

%%%[averCbf diffCbf]

info   = peekInfo('allrois', 'ho1', 'both', 1, 0);
info   = info(:,3);
ninfo  = zeros(size(info,1),1);
for m = 1:size(info,1)
    switch (char(info(m)))
        case 'grey'
            ninfo(m) = 1;
        case 'basal'
            ninfo(m) = 2;
        case 'white'
            ninfo(m) = 3;
        otherwise
            ninfo(m) = 0;
            disp(['skipping info(' num2str(m) ') -> ' info(m)]);
    end
end

%%%if (    size(ninfo,1)  == size(petArb,1) && ...
%%%        size(petArb,1) == size(mrArb,1) &&...
%%%        size(mrArb,1)  == size(extra_tag,1))
    ninfo  = compactArray(ninfo, ninfo > 0 & petArb > 0 & mrArb > 0 & extra_tag);
%%%end
greys  = 1 == ninfo;
basals = 2 == ninfo;
whites = 3 == ninfo;
disp(['size info   -> ' num2str(size(info))]);
disp(['size ninfo  -> ' num2str(size(ninfo))]);
disp(['size greys  -> ' num2str(size(greys))]);
disp(['size basals -> ' num2str(size(greys))]);
disp(['size whites -> ' num2str(size(greys))]);
%%%[greys basals whites]

x_all   = averCbf;
y_all   = diffCbf;
x_grey  = compactArray(averCbf, greys,  -realmax, realmax);
y_grey  = compactArray(diffCbf, greys,  -realmax, realmax);
x_basal = compactArray(averCbf, basals, -realmax, realmax);
y_basal = compactArray(diffCbf, basals, -realmax, realmax);
x_white = compactArray(averCbf, whites, -realmax, realmax);
y_white = compactArray(diffCbf, whites, -realmax, realmax);
size(x_grey)
size(y_grey)
disp('greys cbf->diff(cbf)');
[x_grey y_grey] 
disp('basals cbf->diff(cbf)');
[x_basal y_basal] 
disp('whites cbf->diff(cbf)');
[x_white y_white]

meany   = mean(y_all);
stdy    = std(y_all);
spanx   = min(x_all):max(x_all)-min(x_all):max(x_all);
spanx   = spanx';
onesy   = ones(size(spanx,1),1);
disp(['mean ' mrType ' -> ' num2str(meany)]);
disp(['std  ' mrType ' -> ' num2str(stdy)]);

h = plot(x_grey, y_grey,  'ko ', 'MarkerSize', DINGBAT_SIZE);
    hold all;
    plot(x_basal,y_basal, 'kd ', 'MarkerSize', DINGBAT_SIZE);
    plot(x_white,y_white, 'ks ', 'MarkerSize', DINGBAT_SIZE);
    plot(spanx, meany*onesy,  'k --');
    plot(spanx,-2*stdy*onesy, 'k :');
set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
xlim([XMIN XMAX]);
ylim([YMIN YMAX]);
xlabel(anxlabel, 'FontSize',14);
ylabel(aylabel,  'FontSize',14);
axis square;

legendStrings = {'grey matter', 'basal ganglia', 'white matter', 'mean diff.', '\pm2\sigma'};
hl = legend(legendStrings, 'FontSize', 12, 'Location', 'Northwest'); % 'NorthWest'
legend('boxoff');
plot(spanx, 2*stdy*onesy, 'k :');

set(gcf, 'Color', 'white');
set(gcf, 'Position', PLOT_POSITION);
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [5.5 5.5]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 5.5 5.5]);
set(gcf, 'renderer', 'painters');
hold off;

if (SAVE_TO_DISK)
    plotname = [shortxlabel '_to_' shortylabel];
    hgsave(h, [HOME plotname '.fig'], 'all');
    print(gcf, '-depsc2', '-cmyk', ['-r' num2str(DPI)], [HOME plotname '.eps']);
    print(gcf,                                 '-dpng', [HOME plotname '.png'])
end

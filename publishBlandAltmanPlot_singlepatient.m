%  PUBLISHBLANDALTMANPLOT_SINGLEPATIENT
%
%   Usage:  h = publishBlandAltmanPlot_singlepatient(vxls, mrType, anxlabel, aylabel, shortxlabel, shortylabel)
%
%   See also:  help for predint :: Functions(Curve Fitting Toolbox)
%

function [h, spanx] = publishBlandAltmanPlot_singlepatient(vxls, mrType, anxlabel, aylabel, shortxlabel, shortylabel)

HOME         = '/home/jjlee/';
SAVE_TO_DISK =  1;
DPI          =  1200; % publication quality color postscript
XMIN         =  0;
XMAX         =  100;
YMIN         = -50;
YMAX         =  50;
cd(HOME)

[ho1Cbf, ninfo]  = convertF_singlepatient(vxls, 'CBF');
mrCbf            = convertF_singlepatient(vxls,  mrType);
averCbf          = (ho1Cbf + mrCbf)/2;
diffCbf          = mrCbf - averCbf;
disp('averCbf, diffCbf');
[averCbf diffCbf]

ninfo  = compactArray(ninfo, ninfo > 0 & ho1Arb > 0 & mrArb > 0);
greys  = 1 == ninfo;
basals = 2 == ninfo;
whites = 3 == ninfo;
disp('greys, basals, whites');
[greys basals whites]

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

h = plot(x_grey, y_grey,  'k. ', 'MarkerSize', 4, 'MarkerEdgeColor', [.2 .2 1]);
    hold all;
    plot(x_basal,y_basal, 'k. ', 'MarkerSize', 4, 'MarkerEdgeColor', [1 .2 .2]);
    plot(x_white,y_white, 'k. ', 'MarkerSize', 4, 'MarkerEdgeColor', [.2 1 .2]);
    plot(spanx, meany*onesy,  'k --');
    plot(spanx,-2*stdy*onesy, 'k :');
    legendStrings = {'grey matter', 'basal ganglia', 'white matter', 'mean diff.', '\pm2\sigma'};
hl = legend(legendStrings, 'FontSize', 12);
     set(hl, 'FontSize', 12);
     legend('Location', 'NorthWest');
     %legend('boxoff');
    plot(spanx, 2*stdy*onesy, 'k :');
set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
set(gcf, 'Color', 'white');
xlim([XMIN XMAX]);
ylim([YMIN YMAX]);
xlabel(anxlabel, 'FontSize',14);
ylabel(aylabel,  'FontSize',14);
axis square;
hold off;

if (SAVE_TO_DISK)
    plotname = [shortxlabel ' to ' shortylabel];
    hgsave(h, [HOME plotname '.fig'], 'all');
    print('-depsc2', '-cmyk', '-tiff', ['-r' num2str(DPI)], [HOME plotname '.eps']);
    print(['-f' num2str(gcf)    ], '-dpng', [HOME plotname '.png'])
end

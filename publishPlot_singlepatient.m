% PUBLISHPLOT_SINGLEPATIENT
%
%   Usage:  vxl_cells = publishPlot_singlepatient(pid, mrType, plotname, prev_cells)
%
%           pid        -> int or string
%           mrType     -> 'bayesF', 'F', 'mlemF'
%           plotname   -> string
%           prev_cells -> previous, checkpointed vxl_cells
%

function vxl_cells = publishPlot_singlepatient(pid, mrType, plotname, prev_cells)

dpi = '1200';
HOME = '/home/jjlee/';
SAVE_TO_DISK = 0;

% proxy for enums
HO1 = 1; F = 2; CBFMLEM = 3; REFMLEM = 4;
GREY = 1; BASAL = 2; WHITE = 3;
CONTRA = 1; IPSI = 2;

fwhhHo1 = db('fwhh blur for PET');
fwhhMr  = db('fwhh blur for MR');

switch (nargin)
    case 0
        error(help(plotVoxels_singlepatient));
    case 1
        mrType = 'F';
        plotname = 'tmp'; 
        vxl_cells = 0;
    case 2
        plotname = 'tmp';
        vxl_cells = 0;
    case 3
        vxl_cells = 0;
    case 4
        vxl_cells = prev_cells
    otherwise
        error('plotVoxels_singlePatient:  got too many inputs!');
end

switch (mrType)
    case {'F','bayesF'}
        mrType = 'F';
        mrIdx  = F;
    case {'mlemF', 'Fmlem', 'cbfMlem', 'mlemCbf'}
        mrType = 'cbfMlem'; % for enum translation across functions; TO DO:  use classes
        mrIdx  = CBFMLEM;
    otherwise
        error(['publishPlot_singlepatient did not recognize mrType -> ' mrType]);
end

[pid, p] = ensurePid(pid);
if (~isa(vxl_cells, 'cell'))
    vxl_cells = cell(2,3,2);

    vxl_cells{HO1, GREY,  CONTRA} = peekVoxels(p, 'ho1', 'grey',  'contra', 1, 0, fwhhHo1); 
    vxl_cells{HO1, BASAL, CONTRA} = peekVoxels(p, 'ho1', 'basal', 'contra', 1, 0, fwhhHo1);
    vxl_cells{HO1, WHITE, CONTRA} = peekVoxels(p, 'ho1', 'white', 'contra', 1, 0, fwhhHo1);
    vxl_cells{HO1, GREY,  IPSI}   = peekVoxels(p, 'ho1', 'grey',  'ipsi',   1, 0, fwhhHo1);
    vxl_cells{HO1, BASAL, IPSI}   = peekVoxels(p, 'ho1', 'basal', 'ipsi',   1, 0, fwhhHo1);
    vxl_cells{HO1, GREY,  IPSI}   = peekVoxels(p, 'ho1', 'white', 'ipsi',   1, 0, fwhhHo1);

    vxl_cells{mrIdx, GREY,  CONTRA} = peekVoxels(p, mrType, 'grey',  'contra', 1, 0, fwhhMr); 
    vxl_cells{mrIdx, BASAL, CONTRA} = peekVoxels(p, mrType, 'basal', 'contra', 1, 0, fwhhMr);
    vxl_cells{mrIdx, WHITE, CONTRA} = peekVoxels(p, mrType, 'white', 'contra', 1, 0, fwhhMr);
    vxl_cells{mrIdx, GREY,  IPSI}   = peekVoxels(p, mrType, 'grey',  'ipsi',   1, 0, fwhhMr);
    vxl_cells{mrIdx, BASAL, IPSI}   = peekVoxels(p, mrType, 'basal', 'ipsi',   1, 0, fwhhMr);
    vxl_cells{mrIdx, GREY,  IPSI}   = peekVoxels(p, mrType, 'white', 'ipsi',   1, 0, fwhhMr);
end

xtag = ['PET H_2[^{15}O] CBF / (mL/min/100 g), ' num2str(db('fwhh blur for PET')) ' mm fwhh blur'];
ytag = [mrType 'CBF / arbitrary, ' num2str(db('fwhh blur for MR')) ' mm fwhh blur'];
if (strcmp(mrType, 'F'))
    figure(p)
    ytag = 'LAIF CBF / arbitrary, 10 mm fwhh blur';
else
    figure(100+p)
    ytag = 'MLEM CBF / arbitrary, 10 mm fwhh blur';
end


% vxl_cells % DEBUG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


h1  = plot(vxl_cells{HO1, GREY, CONTRA},  vxl_cells{F, GREY, CONTRA},  'k. ');
set(h1,  'MarkerEdgeColor', [.2 .2 1],   'MarkerSize', 4, 'LineStyle', 'none')
hold all
h2  = plot(vxl_cells{HO1, BASAL, CONTRA}, vxl_cells{F, BASAL, CONTRA}, 'k. ');
set(h2,  'MarkerEdgeColor', [1 .2 .2],   'MarkerSize', 4, 'LineStyle', 'none')
h3  = plot(vxl_cells{HO1, WHITE, CONTRA}, vxl_cells{F, WHITE, CONTRA}, 'k. ');
set(h3,  'MarkerEdgeColor', [.2 1 .2],   'MarkerSize', 4, 'LineStyle', 'none')
h1i = plot(vxl_cells{HO1, GREY,  IPSI},   vxl_cells{F, GREY,  IPSI},   'k. ');
set(h1i, 'MarkerEdgeColor', [.2 .2 1],   'MarkerSize', 4, 'LineStyle', 'none')
h2i = plot(vxl_cells{HO1, BASAL, IPSI},   vxl_cells{F, BASAL, IPSI},   'k. ');
set(h2i, 'MarkerEdgeColor', [1 .2 .2],   'MarkerSize', 4, 'LineStyle', 'none')
h3i = plot(vxl_cells{HO1, WHITE, IPSI},   vxl_cells{F, WHITE, IPSI},   'k. ');
set(h3i, 'MarkerEdgeColor', [.2 1 .2],   'MarkerSize', 4, 'LineStyle', 'none')

set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
set(gcf, 'Color', 'white');
axis square;
xlabel(xtag, 'FontSize',14)
ylabel(ytag, 'FontSize',14)
annotation('textbox', [.5 .75 .05 .05], 'String', 'grey matter', ...
    'FontSize', 12, 'Color', [.2 .2 1], 'FontWeight', 'demi', 'LineStyle', 'none');
annotation('textbox', [.5 .5  .05 .05], 'String', 'basal ganglia', ...
    'FontSize', 12, 'Color', [1 .2 .2], 'FontWeight', 'demi', 'LineStyle', 'none');
annotation('textbox', [.5 .25 .05 .05], 'String', 'white matter', ...
    'FontSize', 12, 'Color', [.2 1 .2], 'FontWeight', 'demi', 'LineStyle', 'none');

%legend(h1,'contra grey','contra basal','contra white','ipsi grey','ipsi basal','ipsi white')
%legendStrings = {'grey matter', 'basal ganglia', 'white matter'};
%legend(legendStrings, 'FontSize', 12);
%legend('Location', 'NorthWest');
x_all = convertF_singlepatient(vxl_cells, 'ho1',   'ho1');
y_all = convertF_singlepatient(vxl_cells, mrType, mrType);

if (isnumeric(x_all) & isnumeric(y_all))
    if (numel(x_all) ~= numel(y_all))
        newlen = min(numel(x_all), numel(y_all));
        x_all = x_all(1:newlen);
        y_all = y_all(1:newlen);
    end
    %disp('[x_all y_all]');
    %[x_all y_all]
    if (numel(x_all) == numel(y_all))
        [cfun, gof, fitout] = fit(x_all, y_all', 'poly1')
        ci = confint(cfun, 0.95)
        cfitted.cfun   = cfun;
        cfitted.gof    = gof;
        cfitted.fitout = fitout;
        cfitted.ci     = ci;
        plot(cfun, 'k -');
    else
        disp(['publishPlot_singlepatient:  Oops numel(x_all) -> ' num2str*(numel(x_all)) 
              ' but numel(y_all) -> ' num2str(numel(y_all))]);
    end
end

hold off

if (SAVE_TO_DISK)

    save([HOME plotname]);
    print('-depsc2', '-cmyk', '-tiff', ['-r' num2str(dpi)], [HOME plotname]);

    hgsave(    p, ['pt' num2str(p) '_laif.fig'],    'all');
    hgsave(100+p, ['pt' num2str(p) '_mlem.fig'],    'all');
    % hgsave(200+p, ['pt' num2str(p) '_refmlem.fig'], 'all');
    print(['-f' num2str(p)    ], '-dpng', ['pt' num2str(p) '_laif.png'])
    print(['-f' num2str(100+p)], '-dpng', ['pt' num2str(p) '_mlem.png'])
    % print(['-f' num2str(200+p)], '-dpng', ['pt' num2str(p) '_refmlem.png'])

end

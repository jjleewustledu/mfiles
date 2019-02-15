%PLOTVOXELS_SINGLEPATIENT
%
%   Usage:  vxl_cells = plotVoxels_singlepatient(pid, plotname, dpi, prev_cells)
%
%           pid        -> int or string
%           plotname   -> string
%           dpi        -> 1200 for MRM printing, int only
%           prev_cells -> previous, checkpointed vxl_cells
%

function vxl_cells = plotVoxels_singlepatient(pid, plotname, dpi, prev_cells)

switch nargin
    case 0
        error(help(plotVoxels_singlepatient));
    case 1
        plotname = 'tmp';
        dpi = '1200';
        vxl_cells = 0;
    case 2
        dpi = '1200';
        vxl_cells = 0;
    case 3
        vxl_cells = 0;
    case 4
        vxl_cells = prev_cells;
    otherwise
        error('plotVoxels_singlePatient:  got too many inputs!');
end

[pid, p] = ensurePid(pid);

HOME = '/home/jjlee/';
SAVE_TO_DISK = 0;
HO1 = 1; F = 2; CBFMLEM = 3; REFMLEM = 4;
GREY = 1; BASAL = 2; WHITE = 3;
CONTRA = 1; IPSI = 2;

if (~vxl_cells)
    
    vxl_cells = cell(3,3,2);

    vxl_cells{HO1, GREY,  CONTRA} = peekVoxels(p, 'ho1', 'grey',  'contra', 1); 
    vxl_cells{HO1, BASAL, CONTRA} = peekVoxels(p, 'ho1', 'basal', 'contra', 1);
    vxl_cells{HO1, WHITE, CONTRA} = peekVoxels(p, 'ho1', 'white', 'contra', 1);
    vxl_cells{HO1, GREY,  IPSI}   = peekVoxels(p, 'ho1', 'grey',  'ipsi',   1);
    vxl_cells{HO1, BASAL, IPSI}   = peekVoxels(p, 'ho1', 'basal', 'ipsi',   1);
    vxl_cells{HO1, GREY,  IPSI}   = peekVoxels(p, 'ho1', 'white', 'ipsi',   1);

    vxl_cells{F, GREY,  CONTRA} = peekVoxels(p, 'F', 'grey',  'contra', 1); 
    vxl_cells{F, BASAL, CONTRA} = peekVoxels(p, 'F', 'basal', 'contra', 1);
    vxl_cells{F, WHITE, CONTRA} = peekVoxels(p, 'F', 'white', 'contra', 1);
    vxl_cells{F, GREY,  IPSI}   = peekVoxels(p, 'F', 'grey',  'ipsi',   1);
    vxl_cells{F, BASAL, IPSI}   = peekVoxels(p, 'F', 'basal', 'ipsi',   1);
    vxl_cells{F, GREY,  IPSI}   = peekVoxels(p, 'F', 'white', 'ipsi',   1);

    vxl_cells{CBFMLEM, GREY,  CONTRA} = peekVoxels(p, 'cbfMlem', 'grey',  'contra', 1); 
    vxl_cells{CBFMLEM, BASAL, CONTRA} = peekVoxels(p, 'cbfMlem', 'basal', 'contra', 1);
    vxl_cells{CBFMLEM, WHITE, CONTRA} = peekVoxels(p, 'cbfMlem', 'white', 'contra', 1);
    vxl_cells{CBFMLEM, GREY,  IPSI}   = peekVoxels(p, 'cbfMlem', 'grey',  'ipsi',   1);
    vxl_cells{CBFMLEM, BASAL, IPSI}   = peekVoxels(p, 'cbfMlem', 'basal', 'ipsi',   1);
    vxl_cells{CBFMLEM, GREY,  IPSI}   = peekVoxels(p, 'cbfMlem', 'white', 'ipsi',   1);

%     vxl_cells{REFMLEM, GREY,  CONTRA} = peekVoxels(p, 'cbfMlem', 'grey',  'contra', 1, 1); 
%     vxl_cells{REFMLEM, BASAL, CONTRA} = peekVoxels(p, 'cbfMlem', 'basal', 'contra', 1, 1);
%     vxl_cells{REFMLEM, WHITE, CONTRA} = peekVoxels(p, 'cbfMlem', 'white', 'contra', 1, 1);
%     vxl_cells{REFMLEM, GREY,  IPSI}   = peekVoxels(p, 'cbfMlem', 'grey',  'ipsi',   1, 1);
%     vxl_cells{REFMLEM, BASAL, IPSI}   = peekVoxels(p, 'cbfMlem', 'basal', 'ipsi',   1, 1);
%     vxl_cells{REFMLEM, GREY,  IPSI}   = peekVoxels(p, 'cbfMlem', 'white', 'ipsi',   1, 1);

end

figure(p)
%subplot(3,1,1)

h1  = plot(vxl_cells{HO1, GREY, CONTRA},  vxl_cells{F, GREY, CONTRA},  'k. ')
set(h1,  'MarkerEdgeColor', [.2 .2 1],   'MarkerSize', 4, 'LineStyle', 'none')
hold all
h2  = plot(vxl_cells{HO1, BASAL, CONTRA}, vxl_cells{F, BASAL, CONTRA}, 'k. ')
set(h2,  'MarkerEdgeColor', [1 .2 .2],   'MarkerSize', 4, 'LineStyle', 'none')
h3  = plot(vxl_cells{HO1, WHITE, CONTRA}, vxl_cells{F, WHITE, CONTRA}, 'k. ')
set(h3,  'MarkerEdgeColor', [.2 1 .2],   'MarkerSize', 4, 'LineStyle', 'none')
h1i = plot(vxl_cells{HO1, GREY,  IPSI},   vxl_cells{F, GREY,  IPSI},   'k. ')
set(h1i, 'MarkerEdgeColor', [.2 .2 1],   'MarkerSize', 4, 'LineStyle', 'none')
h2i = plot(vxl_cells{HO1, BASAL, IPSI},   vxl_cells{F, BASAL, IPSI},   'k. ')
set(h2i, 'MarkerEdgeColor', [1 .2 .2],   'MarkerSize', 4, 'LineStyle', 'none')
h3i = plot(vxl_cells{HO1, WHITE, IPSI},   vxl_cells{F, WHITE, IPSI},   'k. ')
set(h3i, 'MarkerEdgeColor', [.2 1 .2],   'MarkerSize', 4, 'LineStyle', 'none')

set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
set(gcf, 'Color', 'white');
axis square;
xlabel('PET H_2[^{15}O] CBF / (mL/min/100 g), 10 mm fwhh blur', 'FontSize',14)
ylabel('LAIF CBF / arbitrary, 10 mm fwhh blur', 'FontSize',14)
%legend(h1,'contra grey','contra basal','contra white','ipsi grey','ipsi basal','ipsi white')
hold off

figure(100+p)
%subplot(3,1,2)

h4  = plot(vxl_cells{HO1, GREY, CONTRA},  vxl_cells{CBFMLEM, GREY, CONTRA},  'k. ')
set(h4,  'MarkerEdgeColor', [.2 .2 1],   'MarkerSize', 4, 'LineStyle', 'none')
hold all
h5  = plot(vxl_cells{HO1, BASAL, CONTRA}, vxl_cells{CBFMLEM, BASAL, CONTRA}, 'k. ')
set(h5,  'MarkerEdgeColor', [1 .2 .2],   'MarkerSize', 4, 'LineStyle', 'none')
h6  = plot(vxl_cells{HO1, WHITE, CONTRA}, vxl_cells{CBFMLEM, WHITE, CONTRA}, 'k. ')
set(h6,  'MarkerEdgeColor', [.2 1 .2],   'MarkerSize', 4, 'LineStyle', 'none')
h4i = plot(vxl_cells{HO1, GREY,  IPSI},   vxl_cells{CBFMLEM, GREY, IPSI},    'k. ')
set(h4i, 'MarkerEdgeColor', [.2 .2 1],   'MarkerSize', 4, 'LineStyle', 'none')
h5i = plot(vxl_cells{HO1, BASAL, IPSI},   vxl_cells{CBFMLEM, BASAL, IPSI},   'k. ')
set(h5i, 'MarkerEdgeColor', [1 .2 .2],   'MarkerSize', 4, 'LineStyle', 'none')
h6i = plot(vxl_cells{HO1, WHITE, IPSI},   vxl_cells{CBFMLEM, WHITE, IPSI},   'k. ')
set(h6i, 'MarkerEdgeColor', [.2 1 .2],   'MarkerSize', 4, 'LineStyle', 'none')

set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
set(gcf, 'Color', 'white');
axis square;
xlabel('PET H_2[^{15}O] CBF / (mL/min/100 g), 10 mm fwhh blur', 'FontSize',14)
ylabel('MLEM CBF / arbitrary, 10 mm fwhh blur', 'FontSize',14)
%legend(h4,'contra grey','contra basal','contra white','ipsi grey','ipsi basal','ipsi white')
legendStrings = {'grey matter', 'basal ganglia', 'white matter'};
hl = legend(legendStrings, 'FontSize', 12);
     set(hl, 'FontSize', 12);
     legend('Location', 'NorthWest');
hold off

% figure(200+p)
% %subplot(3,1,3)
% 
% h7 = plot(vxl_cells{HO1, GREY, CONTRA},  vxl_cells{REFMLEM, GREY, CONTRA},  'k. ')
% set(h7,  'MarkerEdgeColor', [.1 .1 1],  'MarkerSize', 4, 'LineStyle', 'none')
% hold all
% h8 = plot(vxl_cells{HO1, BASAL, CONTRA}, vxl_cells{REFMLEM, BASAL, CONTRA}, 'k. ')
% set(h8,  'MarkerEdgeColor', [1 .1 .1],  'MarkerSize', 4, 'LineStyle', 'none')
% h9 = plot(vxl_cells{HO1, WHITE, CONTRA}, vxl_cells{REFMLEM, WHITE, CONTRA}, 'k. ')
% set(h9,  'MarkerEdgeColor', [.1 1 .1],  'MarkerSize', 4, 'LineStyle', 'none')
% h7i = plot(vxl_cells{HO1, GREY, IPSI},   vxl_cells{REFMLEM, GREY, IPSI},    'k. ')
% set(h7i, 'MarkerEdgeColor', [0  0 .7],  'MarkerSize', 4, 'LineStyle', 'none')
% h8i = plot(vxl_cells{HO1, BASAL, IPSI},  vxl_cells{REFMLEM, BASAL, IPSI},   'k. ')
% set(h8i, 'MarkerEdgeColor', [.7 0  0],  'MarkerSize', 4, 'LineStyle', 'none')
% h9i = plot(vxl_cells{HO1, WHITE, IPSI},  vxl_cells{REFMLEM, WHITE, IPSI},   'k. ')
% set(h9i, 'MarkerEdgeColor', [0 .7 0],  'MarkerSize', 4, 'LineStyle', 'none')
% 
% xlabel('PET H_2[^{15}O] CBF / (mL/min/100 g), 10 mm fwhh blur')
% ylabel('MLEM SCALED TO W.M.-CBF / (mL/min/100 g), 10 mm fwhh blur')
% %legend(h7,'contra grey','contra basal','contra white','ipsi grey','ipsi basal','ipsi white')
% hold off

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

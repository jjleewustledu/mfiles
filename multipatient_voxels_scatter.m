%
% Usage:    datReturn = multipatient_voxels_scatter(
%                petImg, params, mrImg, masks.white, masks.voxels, masks.basalganglia, masks.arteries, masks.csf, masks.fg, 
%                finalBlur, a_ylabel, plotname)


function datReturn = multipatient_voxels_scatter( ...
         xVec, yVec, a_ylabel, a_title, plotname)

    MARKER_AREA    = 8;
    DPI            = 1200;
    PIXEL_SIZE     = 500;
    GREY_COLOR     = [0 0 0];
    PRINT_EPS      = 1;
    
    petImageName = 'PET H_2[^{15}O] CBF';
    petUnits     = 'mL/min/100 g';
    
    figure('Units', 'pixels', 'Position', [100 100 PIXEL_SIZE PIXEL_SIZE]);
    hold on;
    scatterGrey   = scatter(xVec, yVec);
    
    [voxels.cfun  voxels.gof  voxels.fitout]            = fit(xVec,     yVec,     'poly1');
    voxels.xspan  = 5:5:max(xVec)-5;
    voxels.pi     = predint(voxels.cfun,     voxels.xspan, 0.95, 'functional', 'on');
    voxels.fitted =         voxels.cfun.p1 * voxels.xspan + voxels.cfun.p2;
    plot(voxels.xspan, voxels.fitted, 'k -', 'LineWidth', 0.5); 
    plot(voxels.xspan, voxels.pi,     'k--', 'LineWidth', 0.5);
    
    %set(gca, 'ColorOrder', COLOR_ORDER);
    set(scatterGrey,     'Marker', '.');
    set(scatterGrey,     'SizeData', MARKER_AREA, 'MarkerEdgeColor', GREY_COLOR);

    htitle  = title(a_title);
    hxlabel = xlabel(['Permeability-Corrected ' petImageName ' / (' petUnits ')']);
    hylabel = ylabel(a_ylabel);
    
    set(gca, ...
        'FontName', 'Helvetica', ...
        'Box', 'off', ...
        'TickDir', 'out', ...
        'TickLength', [.02, .02], ...
        'XMinorTick', 'on', ...
        'YMinorTick', 'on', ...
        'XColor', [.3 .3 .3], ...
        'YColor', [.3 .3 .3], ...
        'LineWidth', 1);
    set([htitle, hxlabel, hylabel], 'FontName','AvantGarde');
    set(gca,     'FontSize', 9);
    %%% set(hlegend, 'FontSize', 8);
    set([hxlabel, hylabel, htitle], 'FontSize', 12);

    set(gcf, ...
        'Color', 'white', ...
        'PaperPositionMode', 'auto');
    axis square;
    hold off;
    
    datReturn.voxels           = voxels;
    datReturn.xVec     = xVec;
    datReturn.yVec      = yVec; 
    datReturn.MARKER_AREA    = MARKER_AREA;
    datReturn.DPI            = DPI;
    datReturn.PIXEL_SIZE     = PIXEL_SIZE;
    datReturn.GREY_COLOR     = GREY_COLOR;
    datReturn.PRINT_EPS      = PRINT_EPS;
    
    if (PRINT_EPS & numel(plotname) > 0)
        print(gcf, '-depsc2', '-cmyk', ['-r' num2str(DPI)], [plotname '.eps']); 
        diary([plotname '.txt']);

        disp([a_ylabel ' : GREY MATTER']);
        datReturn.voxels.cfun
        datReturn.voxels.gof
        datReturn.voxels.fitout

        diary off;
    end
    
    

%
% Usage:    datReturn = multi_patient_binvoxels_regression_blandaltman(
%                       xVec, yVec, a_xlabel, a_ylabel, a_title, plotname, metricmax)
%
%           ?Vec:       double column vectors
%           a_*:        strings
%           datReturn:  cell-array of returned data
%           metricmax:  plotting limits

function datReturn = multi_patient_binvoxels_regression_blandaltman( ...
         xVec, yVec, a_xlabel, a_ylabel, a_title, plotname, metricmax)

    % WORKING CONSTANTS
    
    MARKER_AREA  = 16;
    DPI          = 1200;
    PIXEL_SIZE   = 500;
    MARKER_COLOR = [0 0 0];
    PRINT_EPS    = 1;
    NXSPAN       = 100;
    
    % PREALLOCATIONS
    
    if (length(xVec) ~= length(yVec))
        error(['multi_patient_binvoxels_regression_blandaltman:  oops, length(xVec) -> ' ...
               num2str(length(xVec)) ' but length(yVec) -> ' num2str(length(yVec))]); 
    end
    nVoxels = length(xVec);
    voxels  = struct( ...
                 'xVec',       newim(size(xVec)), ...
                 'yVec',       newim(size(yVec)), ...
                 'cfun',       cfit(fittype('poly1'), 0, 0),...
                 'gof',        struct('loss', 0, 'rsquare', 0, 'dfe', 0, 'adjrsquare', 0, 'rmse', 0), ...
                 'fitout',     struct('numobs', 0, 'numparam', 2, ...
                                  'residuals', zeros(nVoxels,1), 'Jacobians', zeros(nVoxels,2), ...
                                  'exitflag', 0, 'algorithm', 'QR factorization and solve', ...
                                  'iterations', 0), ...
                 'xspan',      zeros(1,NXSPAN), ...
                 'pi',         zeros(NXSPAN,2), ...
                 'fitted',     zeros(1,NXSPAN), ...
                 'regres_vec', zeros(nVoxels,1), ...
                 'diff_vec',   zeros(nVoxels,1), ...
                 'mean_vec',   zeros(nVoxels,1));
    
    % REGRESSING   
               
    [voxels.cfun  voxels.gof  voxels.fitout] = fit(xVec, yVec, 'poly1');
    voxels.xspan  = 5:5:max(xVec)-5;
    voxels.pi     = predint(voxels.cfun, voxels.xspan, 0.95, 'functional', 'on');
    voxels.fitted = voxels.cfun.p1* voxels.xspan  + voxels.cfun.p2;
       
    % CALCULATE BLAND-ALTMAN VALUES
    
    voxels.regres_vec = (yVec    - voxels.cfun.p2    )/voxels.cfun.p1;
    voxels.diff_vec   = (voxels.regres_vec  - xVec );
    voxels.mean_vec   = (voxels.regres_vec  + xVec )/2;
    
    voxels.meany = mean(voxels.diff_vec);
    voxels.stdy  = std(voxels.diff_vec);
    voxels.onesy = ones(size(voxels.xspan,2),1);
    
    % MAKE PLOTS
    
    xmin =  0;
    xmax =  metricmax;
    ymin = -metricmax;
    ymax =  metricmax;
    figure('Units', 'pixels', 'Position', [100 100 PIXEL_SIZE PIXEL_SIZE]);
    hold on;
    scatterGrey  = scatter(voxels.mean_vec,  voxels.diff_vec);
    plot(voxels.xspan,     voxels.meany*voxels.onesy, 'k -', 'LineWidth', 0.5);
    plot(voxels.xspan,  -2*voxels.stdy *voxels.onesy, 'k --', 'LineWidth', 0.5);
    plot(voxels.xspan,   2*voxels.stdy *voxels.onesy, 'k --', 'LineWidth', 0.5);    
    
    % CONFIGURE PLOTS
    
    set(scatterGrey,  'Marker', '.');   
    set(scatterGrey,  'SizeData', MARKER_AREA, 'MarkerEdgeColor', MARKER_COLOR);
 
    htitle  = title(a_title);
    hxlabel = xlabel(a_xlabel);
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
    xlim([xmin xmax]);
    ylim([ymin ymax]);
    axis square;
    hold off;
    
    % ASSIGN DATA TO RETURN
    
    datReturn.voxels        = voxels;
    datReturn.MARKER_AREA = MARKER_AREA;
    datReturn.DPI         = DPI;
    datReturn.PIXEL_SIZE  = PIXEL_SIZE;
    datReturn.MARKER_COLOR  = MARKER_COLOR;
    datReturn.PRINT_EPS   = PRINT_EPS;
    
    datReturn.xmin        = xmin;
    datReturn.xmax        = xmax;
    datReturn.ymin        = ymin;
    datReturn.ymax        = ymax;
    
    % PRINT DATA
    
    if (PRINT_EPS && numel(plotname) > 0)
        print(gcf, '-depsc2', '-cmyk', ['-r' num2str(DPI)], [plotname '.eps']); 
        diary([plotname '.txt']);

        disp([a_ylabel ' : GREY MATTER']);
        datReturn.voxels.cfun
        datReturn.voxels.gof
        datReturn.voxels.fitout
        datReturn.voxels.meany
        datReturn.voxels.stdy

        diary off;
    end
    
    

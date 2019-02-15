%
% Usage:    mr = single_patient_voxels_blandaltman(
%           petImg, params, mrImg, masks.white, masks.grey, masks.basalganglia, masks.fg,
%           a_xlabel, a_ylabel, finalBlur, plotname, metricmax)
%
%           mr:         cell-array of returned data
%           params:     cell-array of modality, metric, flows, w, integralCa, a, Iintegral,fwhh
%           masks.fg:       mask for selection of voxels
%           metricmax:  plotting limits
%

function mr = single_patient_voxels_blandaltman( ...
         petImg, mrImg, prmsPet, prmsMr, masks, ...
         a_xlabel, a_ylabel, finalBlur, plotname, metricmax, printProps)

    % WORKING CONSTANTS
    
    MMPPIX_MR      = prmsMr.mmppix;  
    XMIN           = 0;
    CSF_ROIS       = 1;
    
    unity = dip_image(ones(db('sizes3d')));
 
    figure('Units', 'pixels', 'Position', [100 100 printProps.pixelSize printProps.pixelSize]);
    hold on;
    
    % PREALLOCATIONS
    
    N_XSPAN     = 100;  
    masks.tiss  = masks.white | masks.grey | masks.basalganglia;
    nTiss       = sum(masks.tiss);
    nArteries   = sum(masks.arteries);
    nCsf        = sum(masks.csf);
    
    tiss        = struct('mask',       masks.tiss, ...
                         'petImg',     newim(size(petImg)), ...
                         'mrImg',      newim(size(mrImg)), ...
                         'petCbf_vec', zeros(nTiss,1), ...
                         'mrCbf_vec',  zeros(nTiss,1), ...
                         'xspan',      zeros(1,N_XSPAN), ...
                         'diff_vec',   zeros(nTiss,1), ...
                         'mean_vec',   zeros(nTiss,1)); 
    
    arteries    = struct('mask',       masks.arteries, ...
                         'petImg',     newim(size(petImg)), ...
                         'mrImg',      newim(size(mrImg)), ...
                         'petCbf_vec', zeros(nArteries,1), ...
                         'mrCbf_vec',  zeros(nArteries,1), ...
                         'xspan',      zeros(1,N_XSPAN), ...
                         'diff_vec',   zeros(nArteries,1), ...
                         'mean_vec',   zeros(nArteries,1));
                     
    if CSF_ROIS,
        csf   = struct('mask',         masks.csf, ...
                         'petImg',     newim(size(petImg)), ...
                         'mrImg',      newim(size(mrImg)), ...
                         'petCbf_vec', zeros(nCsf,1), ...
                         'mrCbf_vec',  zeros(nCsf,1), ...
                         'xspan',      zeros(1,N_XSPAN), ...
                         'diff_vec',   zeros(nCsf,1), ...
                         'mean_vec',   zeros(nCsf,1)); 
    end                  
                     
    % CALCULATE ROI ARRAYS
    
    [tiss.petCbf_vec tiss.petImg] = ...
        lpeekVoxels_gen(     squeeze(petImg), prmsPet, unity, tiss.mask     & masks.fg);
    [arteries.petCbf_vec arteries.petImg] = ...
        lpeekVoxels_gen(     squeeze(petImg), prmsPet, unity, arteries.mask & masks.fg);
    if CSF_ROIS,
        [csf.petCbf_vec csf.petImg] = ...
            lpeekVoxels_gen( squeeze(petImg), prmsPet, unity, csf.mask      & masks.fg); 
    end    
    
    [tiss.mrCbf_vec tiss.mrImg]  = ...
        lpeekVoxels_gen(     squeeze(mrImg),  prmsMr, unity, tiss.mask      & masks.fg);
    [arteries.mrCbf_vec arteries.mrImg] = ...
        lpeekVoxels_gen(     squeeze(mrImg),  prmsMr, unity, arteries.mask  & masks.fg);
     if CSF_ROIS,
        [csf.mrCbf_vec csf.mrImg] = ...
            lpeekVoxels_gen( squeeze(mrImg),  prmsMr, unity, csf.mask       & masks.fg); 
     end
    
    % CALCULATE BLAND-ALTMAN VALUES
    
    tiss.diff_vec        = (tiss.mrCbf_vec     - tiss.petCbf_vec    );
    tiss.mean_vec        = (tiss.mrCbf_vec     + tiss.petCbf_vec    )/2;
    arteries.diff_vec    = (arteries.mrCbf_vec - arteries.petCbf_vec);
    arteries.mean_vec    = (arteries.mrCbf_vec + arteries.petCbf_vec)/2;
    csf.diff_vec         = (csf.mrCbf_vec      - csf.petCbf_vec     );
    csf.mean_vec         = (csf.mrCbf_vec      + csf.petCbf_vec     )/2;
      
    tiss.meany = mean(tiss.diff_vec);
    tiss.stdy  = std(tiss.diff_vec);
    tiss.onesy = ones(size(tiss.xspan,2),1);
    
    % MAKE PLOTS
    
    scatterTiss     = scatter(tiss.mean_vec, tiss.diff_vec);
    disp(['sum tiss.mean_vec     -> ' num2str(sum(tiss.mean_vec))]);
    disp(['sum tiss.diff_vec     -> ' num2str(sum(tiss.diff_vec))]);
    scatterArteries = scatter(arteries.mean_vec, arteries.diff_vec);
    disp(['sum arteries.mean_vec -> ' num2str(sum(arteries.mean_vec))]);
    disp(['sum arteries.diff_vec -> ' num2str(sum(arteries.diff_vec))]);
    if CSF_ROIS,
        scatterCsf  = scatter(csf.mean_vec, csf.diff_vec); 
        disp(['sum csf.mean_vec      -> ' num2str(sum(csf.mean_vec))]);
        disp(['sum csf.diff_vec      -> ' num2str(sum(csf.diff_vec))]);
    end    
    
    plot(tiss.xspan,       tiss.meany*tiss.onesy, printProps.tissLine1, 'LineWidth', 1.0);
    plot(tiss.xspan, -1.96*tiss.stdy *tiss.onesy, printProps.tissLine2, 'LineWidth', 0.5);
    plot(tiss.xspan,  1.96*tiss.stdy *tiss.onesy, printProps.tissLine2, 'LineWidth', 0.5);   
    
    % CONFIGURE PLOTS
    
    set(scatterTiss,     'Marker', '.');
    set(scatterArteries, 'Marker', '.');
    if CSF_ROIS,
        set(scatterCsf,  'Marker', '.'); end  
    
    set(scatterTiss,     'SizeData', printProps.markerArea, 'MarkerEdgeColor', printProps.colors.tissue);
    set(scatterArteries, 'SizeData', printProps.markerArea, 'MarkerEdgeColor', printProps.colors.arteries);
    if (CSF_ROIS)
        set(scatterCsf,  'SizeData', printProps.markerArea, 'MarkerEdgeColor', printProps.colors.csf); end

    hlegend = legend([scatterTiss, scatterArteries, scatterCsf], ...
                'tissue', 'arteries', 'csf', ...
                'location', 'NorthWest');    
    htitle  = title(['Tissue Voxels Blurred to ' num2str(finalBlur) ' mm Resolution']);
    hxlabel = xlabel(a_xlabel);
    hylabel = ylabel(a_ylabel);
    
    set(gca, ...
        'FontName', printProps.aGca.fontName, ...
        'Box', 'off', ...
        'TickDir', 'out', ...
        'TickLength', [.02, .02], ...
        'XMinorTick', 'on', ...
        'YMinorTick', 'on', ...
        'XColor', [.3 .3 .3], ...
        'YColor', [.3 .3 .3], ...
        'LineWidth', 1);
    set([htitle, hxlabel, hylabel], 'FontName', printProps.aTitle.fontName);
    set(gca,     'FontSize', printProps.aGca.fontSize);
    set(hlegend, 'FontSize', printProps.aLegend.fontSize);
    set([hxlabel, hylabel, htitle], 'FontSize', printProps.aLabel.fontSize);

    set(gcf, ...
        'Color', 'white', ...
        'PaperPositionMode', 'auto');
    xlim([XMIN metricmax]);
    ylim([-metricmax metricmax]);
    axis square;
    hold off;
    
    % ASSIGN DATA TO RETURN
    
    mr.tiss        = tiss;
    mr.arteries    = arteries;    
    mr.MMPPIX_MR   = MMPPIX_MR;
    mr.printProps  = printProps;
    mr.xmin        = XMIN;
    mr.xmax        = metricmax;
    mr.ymin        = -metricmax;
    mr.ymax        = metricmax;
    if (CSF_ROIS)
        mr.csf                   = csf;
        mr.printProps.colors.csf = printProps.colors.csf; 
    end
    
    % PRINT DATA
    
    if (printProps.printEps && numel(plotname) > 0)
        print(gcf, '-depsc2', '-cmyk', ['-r' num2str(printProps.dpi)], [plotname '.eps']); 
        diary([plotname '.txt']);
        disp([a_ylabel ' : ALL TISSUES'])
        mr.tiss.meany
        mr.tiss.stdy
        diary off;
    end
    
    

%
% Usage:    mr = single_patient_voxels_multiscatter(
%                petImg, params, mrImg, masks.white, masks.grey, masks.basalganglia, masks.arteries, masks.csf, masks.fg, 
%                finalBlur, a_ylabel, plotname)
%
%           mr:      cell-array of returned data
%           params:  cell-array of modality, metric, flows, w, integralCa, a, Iintegral,fwhh
%           masks.fg:    mask for selection of voxels
%

function mr = single_patient_voxels_multiscatter( ...
         petImg, mrImg, prmsPet, prmsMr, ...
         masks, ...
         finalBlur, a_ylabel, petImageName, petUnits, plotname)

    MARKER_AREA    = 8;
    DPI            = 1200;
    PIXEL_SIZE     = 500;
    MMPPIX         = prmsMr.mmppix;
    ARTERIES_COLOR = [1  .1  0];
    CSF_COLOR      = [.2 .2 .2];
    WHITE_COLOR    = [0 .1 1];
    GREY_COLOR     = [.1 1 0];
    BASAL_COLOR    = [.5 0 .5];
    PRINT_EPS      = 1;
    BASAL_ROIS     = 1;
    CSF_ROIS       = 1;
    
    if ~BASAL_ROIS,
        masks.basalganglia = newim(size(masks.grey)); end
    
    [blur_pet blur_mr] = blurToFinal(finalBlur);
    
    unity = dip_image(ones(db('sizes3d')));
    
    figure('Units', 'pixels', 'Position', [100 100 PIXEL_SIZE PIXEL_SIZE]);
    hold on;
    
    arteries.mask = masks.arteries;
    csf.mask      = masks.csf;
    white.mask    = masks.white;
    grey.mask     = masks.grey;
    if (BASAL_ROIS)
        basal.mask    = masks.basalganglia;
        tiss.mask     = white.mask | grey.mask | basal.mask;  
    else
        tiss.mask     = white.mask | grey.mask; 
    end

    
    [arteries.petCbf_vec arteries.petCbf] = ...
        lpeekVoxels_gen(squeeze(petImg), prmsPet, unity, arteries.mask & masks.fg);
        [white.petCbf_vec white.petCbf] = ...
        lpeekVoxels_gen(squeeze(petImg), prmsPet, unity,    white.mask & masks.fg);
    [grey.petCbf_vec   grey.petCbf] = ...
        lpeekVoxels_gen(squeeze(petImg), prmsPet, unity,     grey.mask  & masks.fg);
    if BASAL_ROIS,
        [basal.petCbf_vec basal.petCbf] = ...
            lpeekVoxels_gen(squeeze(petImg), prmsPet, unity,    basal.mask & masks.fg); end
    if CSF_ROIS,
        [csf.petCbf_vec csf.petCbf] = ...
            lpeekVoxels_gen(squeeze(petImg), prmsPet, unity,      csf.mask & masks.fg); end
    [petCbf_vec             petCbf] = ...
        lpeekVoxels_gen(squeeze(petImg), prmsPet, unity,     tiss.mask  & masks.fg);

 
    [arteries.mrImg_vec arteries.mrImg] = ...
        lpeekVoxels_gen( squeeze(mrImg), prmsMr, unity, arteries.mask & masks.fg);
    [white.mrImg_vec   white.mrImg] = ...
        lpeekVoxels_gen( squeeze(mrImg), prmsMr, unity,    white.mask & masks.fg);
    [grey.mrImg_vec     grey.mrImg]  = ...
        lpeekVoxels_gen( squeeze(mrImg), prmsMr, unity,     grey.mask  & masks.fg);
    if BASAL_ROIS,
        [basal.mrImg_vec   basal.mrImg] = ...
            lpeekVoxels_gen( squeeze(mrImg), prmsMr, unity,    basal.mask & masks.fg); end
    if CSF_ROIS,
        [csf.mrImg_vec   csf.mrImg] = ...
            lpeekVoxels_gen( squeeze(mrImg), prmsMr, unity,      csf.mask & masks.fg); end
    [mrImg_vec               mrImg] = ...
        lpeekVoxels_gen(squeeze(mrImg), prmsMr, unity,     tiss.mask  & masks.fg);

    
    scatterWhite    = scatter(white.petCbf_vec,    white.mrImg_vec);
    scatterGrey     = scatter(grey.petCbf_vec,     grey.mrImg_vec);
    if BASAL_ROIS,
        scatterBasal    = scatter(basal.petCbf_vec,    basal.mrImg_vec); end
    if CSF_ROIS,
        scatterCsf      = scatter(csf.petCbf_vec,      csf.mrImg_vec); end
    scatterArteries = scatter(arteries.petCbf_vec, arteries.mrImg_vec);

    
    disp('fitting arteries matter voxels...');
    [arteries.cfun arteries.gof arteries.fitout]  = fit(arteries.petCbf_vec, arteries.mrImg_vec, 'poly1');
    disp('fitting white matter voxels...');
    [white.cfun white.gof white.fitout]           = fit(white.petCbf_vec,    white.mrImg_vec,    'poly1');
    disp('fitting grey matter voxels:');
    [grey.cfun  grey.gof  grey.fitout]            = fit(grey.petCbf_vec,     grey.mrImg_vec,     'poly1');
    if (BASAL_ROIS)
        disp('fitting basal ganglia voxels...');
        [basal.cfun basal.gof basal.fitout]           = fit(basal.petCbf_vec,    basal.mrImg_vec,    'poly1');
    end
    if (CSF_ROIS)
        disp('fitting csf matter voxels...');
        [csf.cfun csf.gof csf.fitout]                 = fit(csf.petCbf_vec,      csf.mrImg_vec,      'poly1');
    end
    
    disp('fitting all tissue voxels...');
    [tiss.cfun  tiss.gof  tiss.fitout]            = fit(petCbf_vec,          mrImg_vec,          'poly1');  
    arteries.xspan  = 5:5:max(arteries.petCbf_vec)-5;
    white.xspan     = 5:5:max(white.petCbf_vec)-5;
    grey.xspan      = 5:5:max(grey.petCbf_vec)-5;
    if BASAL_ROIS,
        basal.xspan     = 5:5:max(basal.petCbf_vec)-5; end
    if CSF_ROIS,
        csf.xspan       = 5:5:max(csf.petCbf_vec)-5; end
    arteries.pi     = predint(arteries.cfun, arteries.xspan, 0.95, 'functional', 'on');
    white.pi        = predint(white.cfun,    white.xspan,    0.95, 'functional', 'on');
    grey.pi         = predint(grey.cfun,     grey.xspan,     0.95, 'functional', 'on');
    if BASAL_ROIS,
        basal.pi        = predint(basal.cfun,    basal.xspan,    0.95, 'functional', 'on'); end
    if CSF_ROIS,
        csf.pi          = predint(csf.cfun,      csf.xspan,      0.95, 'functional', 'on'); end
    arteries.fitted = arteries.cfun.p1 * arteries.xspan + arteries.cfun.p2;
    white.fitted    = white.cfun.p1    * white.xspan    + white.cfun.p2;
    grey.fitted     = grey.cfun.p1     * grey.xspan     + grey.cfun.p2;
    if BASAL_ROIS,
        basal.fitted    = basal.cfun.p1    * basal.xspan    + basal.cfun.p2; end
    if CSF_ROIS,
        csf.fitted      = csf.cfun.p1      * csf.xspan      + csf.cfun.p2; end
        

    
    
    plot(white.xspan,    white.fitted,    'b -', 'LineWidth', 0.5); 
    plot(white.xspan,    white.pi,        'b--', 'LineWidth', 0.5);
    plot(grey.xspan,     grey.fitted,     'g -', 'LineWidth', 0.5); 
    plot(grey.xspan,     grey.pi,         'g--', 'LineWidth', 0.5);
    if (BASAL_ROIS)
        plot(basal.xspan,    basal.fitted,    'k -', 'LineWidth', 0.5); 
        plot(basal.xspan,    basal.pi,        'k--', 'LineWidth', 0.5);
    end
    if (CSF_ROIS)
        plot(csf.xspan,      csf.fitted,      'm -', 'LineWidth', 0.5); 
        plot(csf.xspan,      csf.pi,          'm--', 'LineWidth', 0.5);
    end
    plot(arteries.xspan, arteries.fitted, 'r -', 'LineWidth', 0.5); 
    plot(arteries.xspan, arteries.pi,     'r--', 'LineWidth', 0.5);
    
    %set(gca, 'ColorOrder', COLOR_ORDER);
    set(scatterArteries, 'Marker', '.');
    set(scatterWhite,    'Marker', '.');
    set(scatterGrey,     'Marker', '.');
    if BASAL_ROIS,
        set(scatterBasal,    'Marker', '.'); end
    if CSF_ROIS,
        set(scatterCsf,      'Marker', '.'); end
    set(scatterArteries, 'SizeData', MARKER_AREA, 'MarkerEdgeColor', ARTERIES_COLOR);
    set(scatterWhite,    'SizeData', MARKER_AREA, 'MarkerEdgeColor', WHITE_COLOR);
    set(scatterGrey,     'SizeData', MARKER_AREA, 'MarkerEdgeColor', GREY_COLOR);
    hlegend = legend([scatterWhite, scatterGrey, scatterArteries, scatterCsf], ...
            'white matter', 'grey matter', 'arteries', 'CSF', ...
            'location', 'NorthWest'); 
    if (BASAL_ROIS)
        set(scatterBasal,    'SizeData', MARKER_AREA, 'MarkerEdgeColor', BASAL_COLOR);
        hlegend = legend([scatterWhite, scatterGrey, scatterBasal, scatterArteries], ...
            'white matter', 'grey matter', 'basal ganglia', 'arteries', ...
            'location', 'NorthWest');        
    end
    if (CSF_ROIS)
        set(scatterCsf,      'SizeData', MARKER_AREA, 'MarkerEdgeColor', CSF_COLOR);
        hlegend = legend([scatterWhite, scatterGrey, scatterArteries, scatterCsf], ...
            'white matter', 'grey matter', 'arteries', 'CSF', ...
            'location', 'NorthWest');
    end
    if (BASAL_ROIS && CSF_ROIS)
        hlegend = legend([scatterWhite, scatterGrey, scatterBasal, scatterArteries, scatterCsf], ...
            'white matter', 'grey matter', 'basal ganglia', 'arteries', 'CSF', ...
            'location', 'NorthWest');
    end
    htitle  = title(['Tissue Voxels Blurred to ' num2str(max(blur_mr), 2) ' mm Resolution']);
    hxlabel = xlabel(['Permeability-Corrected PET ' petImageName ' / (' petUnits ')']);
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
    set(hlegend, 'FontSize', 8);
    set([hxlabel, hylabel, htitle], 'FontSize', 12);

    set(gcf, ...
        'Color', 'white', ...
        'PaperPositionMode', 'auto');
    axis square;
    hold off;
    
    mr.arteries    = arteries;
    mr.white          = white;
    mr.grey           = grey;
    mr.tiss           = tiss;
    mr.petCbf_vec     = petCbf_vec;
    mr.petCbf         = petCbf;
    mr.mrImg_vec      = mrImg_vec;
    mr.mrImg          = mrImg; 
    mr.blur_pet       = blur_pet;
    mr.blur_mr        = blur_mr;
    mr.MARKER_AREA    = MARKER_AREA;
    mr.DPI            = DPI;
    mr.PIXEL_SIZE     = PIXEL_SIZE;
    mr.MMPPIX         = MMPPIX;  
    mr.ARTERIES_COLOR = ARTERIES_COLOR;
    mr.WHITE_COLOR    = WHITE_COLOR;
    mr.GREY_COLOR     = GREY_COLOR;
    mr.PRINT_EPS      = PRINT_EPS;
    if (BASAL_ROIS)
        mr.BASAL_COLOR    = BASAL_COLOR;
        mr.basal          = basal;
    end
    if (CSF_ROIS)
        mr.CSF_COLOR = CSF_COLOR;
        mr.csf            = csf;
    end
    
    
    
    if (PRINT_EPS & numel(plotname) > 0)
        print(gcf, '-depsc2', '-cmyk', ['-r' num2str(DPI)], [plotname '.eps']); 
        diary([plotname '.txt']);
        disp([a_ylabel ' : WHITE MATTER']);
        mr.white.cfun
        mr.white.gof
        mr.white.fitout
        disp([a_ylabel ' : GREY MATTER']);
        mr.grey.cfun
        mr.grey.gof
        mr.grey.fitout
        if (BASAL_ROIS)
            disp([a_ylabel ' : BASAL GANGLIA']);
            mr.basal.cfun
            mr.basal.gof
            mr.basal.fitout
        end
        disp([a_ylabel ' : ARTERIES']);
        mr.arteries.cfun
        mr.arteries.gof
        mr.arteries.fitout
        if (CSF_ROIS)
            disp([a_ylabel ' : CSF']);
            mr.csf.cfun
            mr.csf.gof
            mr.csf.fitout
        end
        disp([a_ylabel ' : ALL TISSUES']);
        mr.tiss.cfun
        mr.tiss.gof
        mr.tiss.fitout
        diary off;
    end
    
    

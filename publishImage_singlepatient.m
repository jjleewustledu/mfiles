%
%   Usage:  publishImage_singlepatient(img, sl, units, filename, range, colormap, nocolorbar)
%
%           sl       -> int slice to publish
%           units    -> string to display units of the colorbar
%           filename -> stem of postscript2-color file;
%                       empty string for no file-writing
%           range    -> 2-vector of inf, sup image values 	(optional)
%           colormap -> colormap 							(optional)
%           nocolorbar -> bool
%

function img2 = publishImage_singlepatient(img, sl, units, filename, range, map, nocolorbar)
    
    DPI = 600;
    ZOOM_PCNT = 100;
    
    switch (nargin)
        case 4
            range = [];
            map    = 'jet';
            nocolorbar = 0;
        case 5
            map    = 'jet';
            nocolorbar = 0;
        case 6
            nocolorbar = 0;
        case 7
        otherwise
            error(help('single_patient_image'));
    end
    
    %img   = img .* (img < 120);
    
    figure(...
        'Units', 'pixels', ...
        'Color', 'White', ...
        'PaperPositionMode', 'auto');
    %diptruesize(dipfig('-get', 'img', ZOOM_PCNT));
    img = squeeze(img);

    sizes = db('sizes3d');
    img2 = zeros(sizes(1), sizes(2), 3);
    if (isa(img, 'dip_image_array'))
        for rgb = 1:3
            img2(:,:,rgb) = double(img{rgb}(:,:,sl));
        end
    elseif (isa(img,'dip_image'))
        img2 = double(img(:,:,sl));
    end
    
    hshow = imshow(img2, ...
        'Border', 'tight', ...
        'InitialMagnification', ZOOM_PCNT, ...
        'DisplayRange', range);
    
    if (numel(map) > 0)
        a_colormap = colormap(map);
        if (~nocolorbar)            
            a_colorbar = colorbar( ...
                'XColor', 'White', ...
                'YColor', 'White', ...
                'Units', 'pixels', ...
                'location', 'West', ...
                'Position', [10 32 10 192], ...
                'TickDir', 'in', ...
                'FontName', 'AvantGarde', ...
                'FontSize', 16);
            text(128, 22, units, ...
                'Color', 'White', ...
                'Position', [14 14], ...
                'FontName', 'AvantGarde', ....
                'FontSize', 16, ...
                'FontWeight', 'bold', ...
                'Rotation', 0);
            set(gca, 'Color', 'White',  'FontName', 'AvantGarde', 'FontSize', 16, 'FontWeight', 'bold');
        end        
    end
    
    if (numel(filename) > 0)
        disp(['Printing epsc2 in cmyk to ' pwd '/' filename '.eps']);
        print(gcf, '-depsc2', '-cmyk', ['-r' num2str(DPI)], [filename '.eps']); 
    end
    
    img2 = dip_image(img2);
    

function img = imgsum(img, varargin)
    %% IMGSUM ... 
    %   
    %  Usage:  double_sum = imgsum(double_image[, 'xyzt']) 
    %                                             ^ dimensions to sum, e.g., 'x', 'y', 'xy', 'xyz', 't';
    %                                               '' is default which returns double_image unchanged

    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into svn repository $URL$ 
    %% Developed on Matlab 8.5.0.197613 (R2015a) 
    %% $Id$ 

    ip = inputParser;
    addRequired(ip, 'img', @isnumeric);
    addOptional(ip, 'tosum', '', @ischar);
    parse(ip, img, varargin{:});

    rank = length(size(img));
    switch (ip.Results.tosum)
        case 'x'
            img = sum(img,1);
        case 'y'
            img = sum(img,2);
        case 'xy'
            img = sum(sum(img,1),2);
        case 'z'            
            if (rank > 2)
                img = sum(img,3);
            end
        case 'yz'
            if (rank > 2)
                img = sum(sum(img,2),3);
            end
        case 'xyz'
            if (rank > 2)
                img = sum(sum(sum(img,1),2),3);
            end
        case 't'
            if (rank > 3)
                img = sum(img,4);
            end
        case 'xyzt'
            img = sum(sum(sum(sum(img))));
        otherwise
            error('mfiles:unsupportedParamValue', 'tosum -> %s', ip.Results.tosum);
    end
    img = squeeze(img);
    
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/imgsum.m] ======  

%
%   Usage:  img = ensureImage(img0)
%

function img = ensureImage(img0, img1)

    switch (nargin)
        case 1
            img = ensureDipimage(img0);
        case 2
            img = ensureDipimage(img0);
            assert(size(img1,1) == size(img,1));
            assert(size(img1,2) == size(img,2));
            assert(size(img1,3) == size(img,3));
        otherwise
            error(help('ensureImage'));
    end
    
    function img3 = ensureDipimage(img2)
    
        switch class(img2)
            case 'dip_image'
            case 'double'
                img2 = dip_image(img2);
            case 'struct'
            otherwise
                error(['oops...  ensureImage could not recognize the class of img -> ' class(img2)]);
        end
        img3 = squeeze(scrubNaNs(img2));
    
    

    

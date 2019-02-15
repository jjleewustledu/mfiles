% LPEEKVOXELS
%
% Usage:  [theValues imgCheck] = lpeekVoxels(img, msk0, fwhh, wmimg, wmmsk)
%
%         theValues -> vector of doubles, length == num. pos. elements of msk0
%         imgCheck  -> img with blurring, but before sampling, for cross-checks
%         
%         img       -> dipimage object containing data 
%         msk0      -> dipimage object containing mask to apply before filtering
%         msk       -> dipimage object containing mask to select for theValues
%         fwhh      -> fwhh in mm for 3D-Gaussian blurring; no blurring if < eps
%         mmp       -> triplet row vector with mm/pixel for img
%         wmimg     -> white-matter image for rescaling (optional)
%         wmmsk     -> white-matter mask  for rescaling (optional)
%
% See also:  ancestor function peekVoxels
%


function [theValues imgout] = lpeekVoxels(img, msk0, msk, fwhh, mmp, wmimg, wmmsk)

    switch class(img)
        case 'dip_image'
        case 'double'
            img = dip_image(img);
        otherwise
            error(['oops...  lpeekVoxels could not recognize the class of img -> ' class(img)]);
    end
    img = squeeze(scrubNaNs(img));
    switch class(msk0)
        case 'dip_image'
        case 'double'
            msk0 = dip_image(msk0);
        default
            error(['oops...  lpeekVoxels could not recognize the class of msk0 -> ' class(msk0)]);
    end
    msk0 = squeeze(scrubNaNs(msk0)) > eps; % force msk0 to be boolean
    assert(size(msk0,1) == size(img,1));
    assert(size(msk0,2) == size(img,2));
    assert(size(msk0,3) == size(img,3));
    %%% assert(size(size(msk0)) == size(size(img)));

    if (max(fwhh) > eps)
        if nargin < 5,
            error('oops...  lpeekVoxels needs triplet row vector mmp in order to do blurring'); end
        imgout = gaussAnisofFwhh(img, fwhh, mmp); 
    else
        imgout = img;
    end  
    
    if (7 == nargin)
        WM_REF = 22;
        wmmsk = wmmsk > eps; % force to be boolean
        wmValue = sum(wmmsk .* wmimg)/sum(wmmsk);
        imgout = (WM_REF/wmValue) * imgout;
    end
	theValues = peekDoubleVoxels(msk, imgout);
    

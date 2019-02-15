% LPEEKVOXELS_PET
%
% Usage:  [theValues imgCheck] = lpeekVoxels_PET(ho1, flows, msk0, fwhh, wmimg, wmmsk)
%
%         theValues -> vector of doubles, length == num. pos. elements of msk0
%         imgCheck  -> img with blurring, but before sampling, for cross-checks
%         
%         ho1       -> dipimage object containing PET counts 
%         flows     -> array [aflow bflow]
%         msk0      -> dipimage object containing mask to apply before filtering
%         msk       -> dipimage object containing mask to select for theValues
%         fwhh      -> fwhh in mm for 3D-Gaussian blurring; no blurring if < eps
%         mmp       -> triplet row vector with mm/pixel for img
%         wmimg     -> white-matter image for rescaling (optional)
%         wmmsk     -> white-matter mask  for rescaling (optional)
%
% See also:  ancestor function peekVoxels
%


function [theValues imgout] = lpeekVoxels_PET(ho1, flows, msk0, msk, fwhh, mmp, wmimg, wmmsk)

    switch class(ho1)
        case 'dip_image'
        case 'double'
            ho1 = dip_image(ho1);
        otherwise
            error(['oops...  lpeekVoxels could not recognize the class of ho1 -> ' class(ho1)]);
    end
    ho1 = squeeze(scrubNaNs(ho1));
    switch class(msk0)
        case 'dip_image'
        case 'double'
            msk0 = dip_image(msk0);
        default
            error(['oops...  lpeekVoxels could not recognize the class of msk0 -> ' class(msk0)]);
    end
    msk0 = squeeze(scrubNaNs(msk0)) > eps; % force msk0 to be boolean
    assert(size(msk0,1) == size(ho1,1));
    assert(size(msk0,2) == size(ho1,2));
    assert(size(msk0,3) == size(ho1,3));
    %%% assert(size(size(msk0)) == size(size(ho1)));

    if (max(fwhh) > eps)
        if nargin < 6,
            error('oops...  lpeekVoxels needs triplet row vector mmp in order to do blurring'); end
        warning(['size ho1 -> ' num2str(size(ho1))]);
        warning(['fwhh     -> ' num2str(fwhh)]);
        warning(['mmp      -> ' num2str(mmp)]);
        warning(['flows    -> ' num2str(flows)]);
        imgout = counts_to_petCbf3(...
                    gaussAnisofFwhh(ho1, fwhh, mmp), flows(1), flows(2)); 
    else
        imgout = ho1;
    end  
    
    if (7 == nargin)
        WM_REF = 22;
        wmmsk = wmmsk > eps; % force to be boolean
        wmValue = sum(wmmsk .* wmimg)/sum(wmmsk);
        imgout = (WM_REF/wmValue) * imgout;
    end
	theValues = peekDoubleVoxels(msk, imgout);
    

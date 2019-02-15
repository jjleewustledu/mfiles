% lpeekVoxels_gen accepts FourdData objects for images and masks, then returns a double vector of masked values.
%
% Usage:  [theValues imgCheck] = lpeekVoxels_gen(img, params, msk0, msk, wmimg, wmmsk)
%
%         theValues -> vector of doubles, length == num. pos. elements of msk0
%         imgCheck  -> img with blurring, but before sampling, for cross-checks
%         
%         img       -> dipimage object containing PET counts 
%         params    -> modality   -> 'pet', 'mr'
%                      metric     -> 'ho1', 'oc1', 'oo1', 'cbf', 'cbv', 'mtt'
%                      flows      -> [aflow bflow]
%                      w          ->
%                      integralCa ->
%                      a          ->
%                      Iintegral  ->
%                      fwhh       -> fwhh in mm for 3D-Gaussian blurring; no blurring if < eps
%                      mmppix     -> triplet row vector with mm/pixel for img
%         msk0      -> dipimage object containing mask to apply before filtering
%         msk       -> dipimage object containing mask to select for theValues
%         wmimg     -> white-matter image for rescaling (optional)
%         wmmsk     -> white-matter mask  for rescaling (optional)
%
% See also:  peekDoubleVoxels, legacy function peekVoxels
%
% Created by John Lee on .
% Copyright (c) 2008 Washington University School of Medicine.  All rights reserved.
% Report bugs to <bug.perfusion.neuroimage.wustl.edu@gmail.com>.

function [theValues imgout] = lpeekVoxels_gen(imgin, params, msk0, msk, wmimg, wmmsk)

    switch (nargin)
        case 4
            imgin = ensureImage(imgin);
            msk0  = ensureImage(msk0, imgin);
            msk   = ensureImage(msk,  imgin);
            msk0  = msk0 > eps;
            msk   = msk  > eps;
        case 6
            imgin  = ensureImage(imgin);
            msk0   = ensureImage(msk0, imgin);
            msk    = ensureImage(msk,  imgin);
            wmimg  = ensureImage(wmimg);
            wmmsk  = ensureImage(wmmsk, imgin);
            msk0   = msk0  > eps;
            msk    = msk   > eps;
            wmmsk  = wmmsk > eps;
            
        otherwise
            error(help('lpeekVoxels_gen'));
    end

    

    switch (params.modality)
        case 'pet'
            switch (params.metric)
                case {'ho1','cbf'}
                    imgout = gaussAnisofFwhh(imgin, params.fwhh, params.mmppix);
                case {'oc1','cbv'}
                    imgout = gaussAnisofFwhh(imgin, params.fwhh, params.mmppix);
                case {'mtt'}
                    imgout = gaussAnisofFwhh(imgin, params.fwhh, params.mmppix);
                case 'oo1'
                    error(['lpeekVoxels_gen:  processing oo1 is not yet supported']);
%                 case 'cbf'
%                     imgout = counts_to_petCbf(...
%                         gaussAnisofFwhh(imgin, params.fwhh, params.mmppix), params.pnum);
%                 case 'cbv'
%                     imgout = counts_to_petCbv(...
%                         gaussAnisofFwhh(imgin, params.fwhh, params.mmppix), params.w, params.integralCa);
%                 case 'oef'
%                     error(['lpeekVoxels_gen:  processing oef is not yet supported']);
%                     cbf = counts_to_petCbf(...
%                         gaussAnisofFwhh(imgin, params.fwhh, params.mmppix), params.pnum);
%                     cbv = counts_to_petCbv(...
%                         gaussAnisofFwhh(imgin, params.fwhh, params.mmppix), params.w, params.integralCa);
%                     imgout = counts_to_petOEF(...
%                         gaussAnisofFwhh(imgin, params.fwhh, params.mmppix), params.w, params.a, cbf, params.Iintegral, cbv, msk);
                otherwise
                    error(['lpeekVoxels_gen:  could not recognize pet, params.metric -> ' params.metric]);
            end
        case 'mr'
            switch (lower(params.metric))
                case {'f','cbf'}
                    imgout = gaussAnisofFwhh(imgin, params.fwhh, params.mmppix);
                case 'cbv'
                    imgout = gaussAnisofFwhh(imgin, params.fwhh, params.mmppix);
                case 'mtt'
                    imgout = gaussAnisofFwhh(imgin, params.fwhh, params.mmppix);
                otherwise
                    error(['lpeekVoxels_gen:  could not recognize MR, params.metric -> ' params.metric]);
            end
        otherwise
            error(['lpeekVoxels_gen:  could not recognize params.modality -> ' params.modality]);
    end
    
    if (nargin == 6) 
        WM_REF = 22;
        wmValue = sum(wmmsk .* wmimg)/sum(wmmsk);
        imgout = (WM_REF/wmValue) * imgout;
    end
    
	theValues = peekDoubleVoxels(msk, imgout);
    
    

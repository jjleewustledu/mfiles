%
% Usage:    [fwhh_out mrpoint_profile gofs fitout] = fwhh_mrPointspread(fwhh_in, mmppix)
%               
%           fwhh_in         -> vector of fwhh/mm
%           mmppix          -> vector of mmppix 
%           mrpoint_profile -> 2-vector of 1D point-spreads for cross-checking
%           gofs            -> goodness of fits from fit(...)
%           fitout          -> output from fit(...)
%
%           only vector-subspaces in R^2 are used
%___________________________________________________________________________

function [fwhh_out mrpoint_profile gofs fitout] = fwhh_mrPointspread(fwhh_in, mmppix)
    
    VERBOSE = 0;
    N       = 256;
    fwhh_in = embedInVector(fwhh_in, 2);
    mmppix  = embedInVector(mmppix, 2);
    
    if (VERBOSE)
        disp(['fwhh_in -> ' num2str(fwhh_in)]);
        disp(['mmppix  -> ' num2str(mmppix)]);
    end
    
    mrpoint              = newim(N,N);
    mrpoint(N/2,N/2)     = 1;
    mrpoint_3g           = gaussAnisofFwhh(mrpoint, fwhh_in, mmppix);
    mrpoint_profile      = newim(2,N);
    mrpoint_profile(0,:) = squeeze(mrpoint_3g(:,N/2));
    mrpoint_profile(1,:) = squeeze(mrpoint_3g(N/2,:)); 
    dmrpoint_profile     = double(mrpoint_profile)';
    
    mm_values      = zeros(2,N);
    mm_values(1,:) = 0:mmppix(1):mmppix(1)*(N - 1);
    mm_values(2,:) = 0:mmppix(2):mmppix(2)*(N - 1);

    if (VERBOSE)
        disp(['size(dmrpoint_profile) -> ' num2str(size(dmrpoint_profile))]);
        disp(['size(mm_values)        -> ' num2str(size(mm_values))]);
        [gfit1 gof1 out1] = fit(squeeze(mm_values(1,:))', squeeze(dmrpoint_profile(1,:))', 'gauss1')
        [gfit2 gof2 out2] = fit(squeeze(mm_values(2,:))', squeeze(dmrpoint_profile(2,:))', 'gauss1')
    else
        [gfit1 gof1 out1] = fit(squeeze(mm_values(1,:))', squeeze(dmrpoint_profile(1,:))', 'gauss1');
        [gfit2 gof2 out2] = fit(squeeze(mm_values(2,:))', squeeze(dmrpoint_profile(2,:))', 'gauss1');
    end  
    
    fwhh_out(1) = mlfourd.NiiBrowser.sigma2width(gfit1.c1/sqrt(2)); % fitted input is in mm
    fwhh_out(2) = mlfourd.NiiBrowser.sigma2width(gfit2.c1/sqrt(2));
    gofs(1)     = gof1;
    gofs(2)     = gof2;
    fitout(1)   = out1;
    fitout(2)   = out2;
    

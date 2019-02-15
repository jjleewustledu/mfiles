%
%   Usage:  [fwhh_out test_profile gofs fitout test_3g test] = fwhh_petPointspread(fwhh_in, zoom, mmppix)
%
%           fwhh_in:        in mm
%           mmppix:         for converting to pixels;
%                           defaults zoom -> 1:  0.440484
%                                    zoom -> 0:  2.086344
%           zoom:           bore center <-> 1; bore periphery at radius of cortical ribbon <-> 0  
%
%			fwhh_out:		in mm
%			test_profile:	1D-profile after 3D-Gaussian blur
%			gofs:			goodness of fit from fit(...)
%			fitout:			outputs from fit(...)
%			test_3g:		image after 3D-Gaussian blur
%			test:			image before 3D-Gaussian blur
%
%           N.B.:       blurring PET by it's intrinsic point-spread fwhh = 3.7825 mm 
%                       yields a new point-spread which is 5.5168 mm.

function [fwhh_out test_profile gofs fitout test_3g test] = fwhh_petPointspread(fwhh_in, zoom, mmppix)

    VERBOSE = 0;
    switch (nargin)
		case 0
			fwhh_in = 0; % returns fwhh_out with native PET resolution at bore periphery
            zoom    = 0;  % 1 -> bore center; 0 -> bore periphery at radius of cortical ribbon
			mmppix  = 2.086344;
		case 1
			zoom   = 0;  % 1 -> bore center; 0 -> bore periphery at radius of cortical ribbon
			mmppix = 2.086344; 
		case 2
			if (zoom) mmppix = 0.440484;
            else      mmppix = 2.086344; end
		case 3
		otherwise
			error(help('fwhh_petPointspread'));
	end
            
    if (zoom)
        test = read4d('/mnt/hgfs/jjlee/Archive/PET/Calibrating resolutions/line_v71r1b_2d_zoom.4dfp.img', 'ieee-be', 'float', 128, 128, 47, 1, 0,0,0);
        test_3g = gaussAnisofFwhh(test(:,:,:,0), [fwhh_in fwhh_in 0], [mmppix mmppix 3.125]); %  mmppix -> [0.440484 0.440484 3.125] 
        test_profile = squeeze(test_3g(:,61,26)); % (:,61,26)
        dtest_profile = double(test_profile);
        % size(dtest_profile)
        xvalues = 0:mmppix:mmppix*(size(dtest_profile,2) - 1);
    else
        test = read4d('/mnt/hgfs/jjlee/Archive/PET/Calibrating resolutions/line2d.4dfp.img', 'ieee-be', 'float', 128, 128, 47, 1, 0,0,0);
        test_3g = gaussAnisofFwhh(test(:,:,:,0), [fwhh_in fwhh_in 0], [mmppix mmppix 3.125]); %  mmppix -> [2.086344 2.086344 3.125] 
        test_profile = squeeze(test_3g(:,100,26)); % (:,100,26)
        dtest_profile = double(test_profile);
        % size(dtest_profile)
        xvalues = 0:mmppix:mmppix*(size(dtest_profile,2) - 1);
    end    
    % size(xvalues)

    if (VERBOSE)
        [gfit gofs fitout] = fit(xvalues', dtest_profile', 'gauss1')
    else
        [gfit gofs fitout] = fit(xvalues', dtest_profile', 'gauss1');
    end
    fwhh_out = mlfourd.NiiBrowser.sigma2fwhh(gfit.c1/sqrt(2), 1); % fitted input is in mm

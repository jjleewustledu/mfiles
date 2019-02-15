%
%   Usage:  fg = makefg2(epiframe, sizes, maxpxls, dcoeff)
%           epiframe:  single time-frame from an EPI study
%           sizes:     4-vector
%           dcoeff:    delta coeff in thresholds for fg (optional)
%           maxpxls:   max. num. true pixels in fg (optional)
%
%__________________________________________________________________________________
    
    function [fg fgnii] = makefg2(epiframe, sizes, maxpxls, dcoeff)
    
        switch (nargin)
            case 2
                maxpxls = 0.667*sizes(1)*sizes(2)*sizes(3);
                dcoeff = 0.1;
            case 3
                dcoeff = 0.1;
            case 4
            otherwise
                error(help('makefg2'));
        end
        
        fg          = squeeze(epiframe > eps);
        meanepi     =    mean(epiframe);
        stdepi      =     std(epiframe);
        coeff       =    -max(epiframe)/stdepi/2;
        while (sum(fg) > maxpxls) 
            fg      = thresholdedBool(epiframe, coeff, meanepi, stdepi);
            disp(['get7ROis:  coeff = ' num2str(coeff) ' sum(fg) = ' num2str(sum(fg))]);
            coeff   = coeff + dcoeff;
            if (meanepi + coeff*stdepi > max(epiframe)); break; end
        end
        
        fgnii = make_nii(fg, [0.8984 0.8984 5], [0 0 0], 16);

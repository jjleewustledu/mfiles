%
%   Usage:  roibool = thresholdedBool(roifloat, coeff, meanroi0, stdroi0)
%
%           meanroi0, stdroi0 are optional
%_______________________________________________________________

function roibool = thresholdedBool(roifloat, coeff, meanroi0, stdroi0)
    switch (nargin)
        case 1
            coeff = 1;
            meanroi = mean(roifloat);
            stdroi  = std(roifloat);
        case 2
            meanroi = mean(roifloat);
            stdroi  = std(roifloat);
        case 3
            meanroi = meanroi0;
            stdroi  = std(roifloat);
        case 4
            meanroi = meanroi0;
            stdroi  = stdroi0; 
        otherwise
            error(['get7Rois.thresholdedBool was passed ' num2str(nargin) ' parameters']);
    end
    roibool = squeeze(roifloat) > (meanroi + coeff*stdroi);

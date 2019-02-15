%PEEKDECONVCONTEXT
%
% Usage:  theImg = peekDeconvContext('cbf', 'mlem', datapath, lens, imgFormat, p)
%

function theImg = peekDeconvContext(metric, method, datapath, lens, imgFormat, p)

[pid, p]  = ensurePid(p);

METRIC    = upper(metric);
METHOD    = upper(method);
blankImg  = newim(lens(1),lens(2),lens(3),lens(4));
if nargin < 5, imgFormat = 'double'; end

CENTRAL_VOLUME = 'SHIMONY';
KIND           = 'ONE_CBF_VALUE';
TAG            = 'LMfit2';
HCT            = 'VONKEN';
FILTER         = 'NO_FILTER';

theImg = blankImg;
name   = 'unknown';
try
    if (12 == p)
        name = [datapath 'OSTERGAARD_' METRIC '_' METHOD '_LOGFRACTAL_' HCT '_' FILTER '.4dfp.img'];
        disp(['trying name -> ' name]);
    elseif (17 == p)
        name = [datapath 'OSTERGAARD_' METRIC '_' METHOD '_LOGFRACTAL_' HCT '_' FILTER '_LMfit2.4dfp.img'];
        disp(['trying name -> ' name]);
    else       
        if (strcmp('ONE_CBF_VALUE', KIND))
            name = [datapath lower(metric) '_' METHOD '.4dfp.img'];
            disp(['trying name -> ' name]);
        elseif (strcmp('CBF_FROM_QUOTIENT', KIND))
            name = [datapath CENTRAL_VOLUME '_' METRIC '_' METHOD '_LOGFRACTAL_' HCT '_' FILTER '_' TAG '.4dfp.img'];
            disp(['trying name -> ' name]);
        else
            error(['peekDeconvContext could not recognize KIND -> ' KIND]);
        end
    end
    theImg = read4d(name,'ieee-be','single',lens(1),lens(2),lens(3),lens(4),0,0,0);
catch
    try
		if (strcmp('ONE_CBF_VALUE', KIND))
			name = [datapath lower(metric) '_' METHOD '_' mlemDateTime(p, metric) '.4dfp.img'];
	        disp(['trying name -> ' name]);
        elseif (strcmp('CBF_FROM_QUOTIENT', KIND))
            timeSig = '0';
            switch (method)
                case 'mlem'
                    timeSig = mlemTimes(p, metric);
                case 'osvd'
                    timeSig = osvdTimes(p, metric);
                case 'ssvd'
                    timeSig = ssvdTimes(p, metric);
                otherwise
                    error(['peekDeconvContext could not recognize ' kindImg]);
            end
            name   = [datapath CENTRAL_VOLUME '_' METRIC '_' METHOD '_LOGFRACTAL_' HCT '_' FILTER '_time' timeSig '.4dfp.img'];  
            disp(['trying name -> ' name]);
            theImg = read4d(name,'ieee-be','single',lens(1),lens(2),lens(3),lens(4),0,0,0);
        else
            error(['the image could not be read from ' name]);
        end
    catch
        error(['the image could not be read from ' name]);
    end
end
disp(['peekDeconvContext found ' name]);

switch (char(imgFormat))
    case 'dip'
    otherwise
        theImg = double(theImg);
end

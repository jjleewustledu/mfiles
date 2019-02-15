%PEEKDOUBLECOORD
%
% Usage:  dbleCoord = peekDoubleCoord(roi, img, moment, pid, kindImg)
%
%         roi, img are dipimage or double objects
%         moment is an integer
%         pid, kindImg are optional
%
% Notes:  internal arithmetic is done with dipimage forms
%______________________________________________________

function dbleCoord = peekDoubleCoord(roi, img, moment, pid, kindImg)

VERBOSE    =  1;
BASE_DIMS  =  3;
moment0    = -1;
moment1    = -1;
moment2    = -1;
dbleCoord  = -1;
NULL_VALUE = -10;

switch(nargin)
	case {1,2}
		moment  = 1;
        pid     = 4;
        kindImg = 'ho1';
    case 3
        pid     = 4;
        kindImg = 'ho1';
	case 4
        kindImg = 'ho1';
    case 5
    otherwise
		error(help('peekDoubleCoord'));
end

[pid, p] = ensurePid(pid);

img = squeeze(img);
roi = squeeze(roi);
imgDims = size(size(img), 2);
if imgDims ~= size(size(roi), 2),
	error(['peekDoubleCoord:  could not reconcile ' num2str(size(size(roi),2)) ' dims of roi with '...' ...
	       num2str(imgDims) ' dims of img']); end	
workingDims = imgDims - BASE_DIMS;

roi = dip_image(scrubNaNs(roi)) > 0; % convert to boolean
img = dip_image(scrubNaNs(img));

if (moment >= 0)
    moment0 = sum(sum(sum(roi)));
    if moment0 < 0, 
        error('moment0 < 0'); end % something is terribly wrong
    dbleCoord = double(moment0);
end

% sample average ---------------------------------------------------------------------------------
if (moment >= 1)
    if (VERBOSE >= 2)
        disp(['peekDoubleCoord:  displaying dip_image(img) and dip_image(roi.*img) for debugging']);
        dip_image(img)
        dip_image(roi.*img)
    end
	switch (workingDims)
		case 0
			moment1 = sum(sum(sum(roi.*img)))/moment0;
		case {1,2}
			moment1 = sum(sum(sum(sum(sum(roi.*img)))))/moment0;
    	otherwise
			error(['peekDoubleCoord:  does not support image dims -> ' num2str(imgDims) ' ...']);
	end
    dbleCoord = double(moment1);
end

% standard error of measurement of the mean (of sample, not of the population) ---------------------
if (moment >= 2)
	if (moment0 > eps)
		switch (workingDims)
			case 0
				moment2 = sqrt(sum(sum(sum((roi.*img - moment1*roi).^2)))/moment0) / sqrt(moment0);
			case {1,2}
				moment2 = sqrt(sum(sum(sum(sum(sum((roi.*img - moment1*roi).^2)))))/moment0) / sqrt(moment0);
			otherwise
				error(['peekDoubleCoord:  does not support image dims -> ' num2str(imgDims) ' ...']);
		end
	else
		disp(['peekDoubleCoords:  WARNING:  moment0 was ' num2str(moment0)]);
		moment2 = -1;
	end
    dbleCoord = double(moment2);
end

if (moment >= 3)
    error(['peekDoubleCoord:  moment ' num2str(moment) ' is not yet supported....']);
end

if (VERBOSE || dbleCoord < 0) 
	disp(['peekDoubleCoord:  moments -> ' num2str(moment0) ', ' num2str(moment1) ', ' num2str(moment2) ' ...']); 
end

clear roi;
clear img;

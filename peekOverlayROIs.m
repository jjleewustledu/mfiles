%PEEKOVERLAYROIS
%
% Usage:  	theImg = peekOverlayROIs(inImg, rois, imgType, imgFormat, overlayColor)
%
%					imgType   (obsolete)
%					imgFormat (obsolete)
%					overlayColor, [r g b]
%

function theImg = peekOverlayROIs(inImg, rois_, imgType, imgFormat, overlayColor)
 
switch (nargin)
	case {3,4}
		overlayColor = [200 0 0];
	case 5
	otherwise
		error(help('peekOverlayROIs'))
end

inImg        = squeeze(inImg);
lens         = size(inImg);
if size(lens,2) < 2, error(['Oops.   inImg had lens -> ' num2str(lens)]); end
if size(lens,2) < 3, lens(3) = 1; end
if size(lens,2) < 4, lens(4) = 1; end
blankImg     = newim(lens(1),lens(2),lens(3));
theImg       = blankImg;
if nargin < 3, imgType   = 'not PET'; end
if nargin < 4, imgFormat = 'double'; end

rois_ = squeeze(rois_);
tmp = 255*inImg/max(max(max(inImg)));
tmp = squeeze(tmp);
disp(['tmp size -> ' num2str(size(tmp)) '; rois_ size -> ' num2str(size(rois_))]);
theImg = overlay(tmp, rois_, overlayColor);

switch char(imgFormat)
    case 'dip'
    otherwise
        warning('peekOverlayROIs can only return dip images');
        %%% theImg = double(theImg);
end

% niiprint prints nii structs to files, e.g., postscript.
%
% Instantiation:    [h, toprint] = niiprint(nii, fg, fg1)
%
%                   nii:    NIfTI struct (cf. help load_nii)
%                   fg:     mask applied before blur
%                   fg1:    ...           after blur
%                   h:      figure handle
%
% Requires: mlniftitools
%
% Created by John Lee on 2008-12-20.
% Copyright (c) 2008 Mallinckrodt Institute of Radiology. All rights reserved.
% Report bugs to <bug.perfusion.neuroimage.wustl.edu@gmail.com>.

function [h, toprint] = niiprint(nii, fg, fg1)

BLUR      = [0 0 0]
RANGE     = [-1 9]
COLORMAP  = jet(256); disp('COLORMAP = jet(256)');
NORMALIZE = 'frac. diff. from mean' % 'frac. of mean' % 'diff. from mean', % 'frac. diff. from mean', % 'none' 

switch (nargin)
    case 1
        fg  = ones(size(nii.img));
        fg1 = ones(size(nii.img));
    case 2
        mmppix = [nii.hdr.dime.pixdim(2) nii.hdr.dime.pixdim(3) nii.hdr.dime.pixdim(4)];
        fg1    = gaussAnisofFwhh(fg, BLUR, mmppix);
    case 3
    otherwise
        error(help('niiprint'));
end
switch (class(nii))
    case 'struct'
        assert(isnumeric(nii.img), ...
            'NIL:niiprint:TypeErr:unrecognizedType', ...
            ['type of nii.img was unexpected: ' class(nii.img)]);
    case 'char'
        fname = nii;
        try
            nii = mlfourd.NIfTI.load(fname);
        catch ME
            nii = mlfourd.NIfTI.load([fname '.4dfp']);
        end
    otherwise
        error(['niiprint could not recognize class of nii -> ' class(nii)]);
end

tmp  = blurNii(nii, BLUR, fg, fg1);
dtmp = dip_image(tmp.img);
for z = 0:size(tmp.img,3)-1 % display radiological convention
    dtmp(:,:,z) = dip_image(double(dtmp(:,:,z))');
end
disp(['mean nii.img -> ' num2str(mean(dtmp))]);
disp(['std  nii.img -> ' num2str( std(dtmp))]);
disp(['max  nii.img -> ' num2str( max(dtmp))]);
switch (NORMALIZE)
	case 'diff. from mean'
		toprint = dtmp - mean(dtmp)*dip_image(ones(size(dtmp)));
	case 'frac. of mean'
    	toprint = dtmp/mean(dtmp);
	case 'frac. diff. from mean'
		toprint = dtmp/mean(dtmp) - dip_image(ones(size(dtmp)));
	otherwise % 'none'
    	toprint = dtmp;
end
h = dipfig('toprint');
dipshow(toprint, RANGE, COLORMAP);

end

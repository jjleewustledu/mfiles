% blurNii applies a blurring algorithm to the passed NIFTI struct.  Factory design pattern.
% Only aniso. Gaussian blurring is supported at present.
%
% Instantiation:    outnii = blurNii(nii, fwhh, msk, msk1)
%
%                   outnii, nii:    NIfTI struct (cf. help load_nii)
%                   fwhh:           FWHH of blurring kernel
%					msk:            double mask to apply prior to blurring
%                   msk1:           double mask ...      after blurring
%
% Created by John Lee on 2008-12-11.
% Copyright (c) 2008 Mallinckrodt Institute of Radiology. All rights reserved.
% Report bugs to <bug.perfusion.neuroimage.wustl.edu@gmail.com>.

function outnii = blurNii(nii, fwhh, msk, msk1)

FWHH_DEFAULT = [10 10 0];

switch (nargin)
    case 1
        assert(isstruct(nii), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of nii was unexpected: ' class(nii)]);
        assert(isnumeric(nii.img), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of nii.img was unexpected: ' class(nii.img)]);
        fwhh = FWHH_DEFAULT;
        msk  = ones(size(nii.img));
        msk1 = ones(size(nii.img));
    case 2
        assert(isstruct(nii), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of nii was unexpected: ' class(nii)]);
        assert(isnumeric(nii.img), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of nii.img was unexpected: ' class(nii.img)]);
        assert(isnumeric(fwhh), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of fwhh was unexpected: ' class(fwhh)]);
        msk  = ones(size(nii.img));
        msk1 = ones(size(nii.img));
    case 3
        assert(isstruct(nii), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of nii was unexpected: ' class(nii)]);
        assert(isnumeric(nii.img), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of nii.img was unexpected: ' class(nii.img)]);
        assert(isnumeric(fwhh), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of fwhh was unexpected: ' class(fwhh)]);
        assert(prod(size(nii.img)) == prod(size(msk)),  ...
            'NIL:blurNii:SizeErr:incompatibleSize', ...
            ['size of nii.img -> ' num2str(size(nii)) ', '  ...
             'size of msk     -> ' num2str(size(msk))]);
        msk1 = ones(size(nii.img));
    case 4
        assert(isstruct(nii), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of nii was unexpected: ' class(nii)]);
        assert(isnumeric(nii.img), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of nii.img was unexpected: ' class(nii.img)]);
        assert(isnumeric(fwhh), ...
            'NIL:blurNii:ctor:TypeErr:unrecognizedType', ...
            ['type of fwhh was unexpected: ' class(fwhh)]);
        assert(prod(size(nii.img)) == prod(size(msk)),  ...
            'NIL:blurNii:SizeErr:incompatibleSize', ...
            ['size of nii.img -> ' num2str(size(nii)) ', '  ...
             'size of msk     -> ' num2str(size(msk))]);
        assert(prod(size(nii.img)) == prod(size(msk1)),  ...
            'NIL:blurNii:SizeErr:incompatibleSize', ...
            ['size of nii.img -> ' num2str(size(nii)) ', '  ...
             'size of msk1    -> ' num2str(size(msk1))]);
    otherwise
        error('NIL:blurNii:ctor:PassedParamsErr:numberOfParamsUnsupported', ...
            help('blurNii'));
end

mmppix     = [nii.hdr.dime.pixdim(2) nii.hdr.dime.pixdim(3) nii.hdr.dime.pixdim(4)];
outnii     = nii;
outnii.img = msk1 .* gaussAnisofFwhh(nii.img .* msk, fwhh, mmppix);

end


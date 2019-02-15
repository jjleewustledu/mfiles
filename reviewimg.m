function [hh, dd] = reviewimg(iobj, descrip, hh, dd)

%POSITION = [128 128 512 512];

assert(mlfourd.NIfTI.isNIfTI(iobj));
if (nargin < 2); descrip = ['the NIfTI ' iobj.fileprefix]; end
if (nargin < 3); hh = {[]}; end
if (nargin < 4); dd = {[]}; end
reply = input(['please review ' descrip ' (return accepts, [a-z] skips): ' ], 's');
if (isempty(reply))
    %iobj.dipshow;
    dd_        = dip_image(iobj.img);
    figwin     = length(hh) + 1;
    hh{figwin} = dipshow(flip4d(dd_, 'yt'), [], 'grey');
    %hh{figwin} = dipfig(figwin, 'dd_', POSITION);
    dd{figwin} = dd_;
    input('return continues..... ');
end

%IMMORPH
%
%   Usage:  outim = immorpph(im, key, radius)
%
%           outim, im -> dipimage objects
%           key       -> 'erode', 'dilate', 'open', 'close'
%           radius    -> radius of ellipsoidal strel()
%

function outim = immorph(im, key, radius)

if (isa(im, 'dip_image'))
    im = double(im);
end
sizes  = size(im);
aSlice = zeros(sizes(1), sizes(2));
SLICES = sizes(3);
FRAME  = 1;
outim  = zeros(sizes(1), sizes(2), SLICES, FRAME);

BALL_HEIGHT = 3;
BALL_N = 0; %%% cf. Image Proc. Toolbox User's Guide:  strel
SE = strel('ball', radius, BALL_HEIGHT, BALL_N); %%% strel('diamond',radius);

for sl = 1:SLICES
    aSlice = squeeze(im(:,:,sl,FRAME));
    switch lower(key)
        case ('erode')
            outim(:,:,sl,FRAME) = imerode(aSlice, SE);   
        case ('dilate')
            outim(:,:,sl,FRAME) = imdilate(aSlice, SE);
        case ('open')
            outim(:,:,sl,FRAME) = imopen(aSlice, SE);
        case ('close')
            outim(:,:,sl,FRAME) = imclose(aSlice, SE);            
    end    
end



outim = dip_image(outim);


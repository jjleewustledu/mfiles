%
% USAGE:    imgout = paintGridlines(nbin)
%

function imgout = paintGridlines(nbin)

    imgin = newim(db('sizes3d'));
    sizes = size(imgin);
    value = 1;

    imgout = imgin;

    for y = 0:sizes(2)-1
        for x = 0:sizes(1)-1
            if (0 == mod(x+1,nbin) | 0 == mod(y+1,nbin))
                imgout(x,y,:) = value;
            end
        end
    end

    
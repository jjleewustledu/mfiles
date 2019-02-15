function outimage = setNaNs(inimage)

if isa(inimage, 'double'), inimage = dip_image(inimage); end
sz   = size(inimage);
szs  = size(sz);
rank = szs(2);

switch rank
    case {1}
        outimage = setNaNs_1D(inimage);
    otherwise
        error(['oops... rank of image to inject with NaNs is ' num2str(rank) ' and is not supported']);  
end

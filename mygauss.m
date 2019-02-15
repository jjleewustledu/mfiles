%MYGAUSS performs anisotropic low-pass filtering with a Gaussian
%
% out_img = mygauss(sigmaxy, sigmaz, in_img)
%
%         - sigmaxy and sigmaz are real > 0
%         - both dip_image and double objects recognized

function out_im = mygauss(sigmaxy, sigmaz, in_img)

if (isa(in_img, 'dip_image'))
    in_mat = double(in_img);
else 
    in_mat = in_img;
end

len  = ceil(6*max(sigmaxy, sigmaz));
cent = len/2;
h = zeros(len, len, len, 1);
norm = 0;
for i = 1:len
    for j = 1:len
        for k = 1:len
            h(i,j,k,1) = exp(-((i-cent)^2 + (j-cent)^2)/(2*sigmaxy^2)) * exp(-(k-cent)^2/(2*sigmaz^2));
            norm = norm + h(i,j,k,1);
        end
    end
end
h = h/norm;
out_im = dip_image(imfilter(in_mat, h));
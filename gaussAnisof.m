
% GAUSSANISOF performs Gaussian, anisotropic low-pass filtering
%
% Usage:    out_img = gaussAnisof(in_img, sigma)
%                   = gaussAnisof(in_img, [sigma1 sigma2])
%                   = gaussAnisof(in_img, [sigma1 sigma2 sigma3])
%
%           out_img:  dip_image object
%           in_img:   dip_image or double object
%           sigma:    scalar or row vector of standard deviations, pixel units
%           
%           required:  length(sigma) == rank(in_img)
%
% Maintainence: easy to err in using size() & size(size(), n)
%               h1, h0 are internal arrays passed back for debugging
%

function [out_im h1 h0] = gaussAnisof(in_img, sigma0)

    KERNEL_MULT = 3; % determines filter kernel size in multiples of sigma
        
    in_img = squeeze(in_img);
    if (1 == numel(sigma0) && 1 < size(size(in_img),2))
        sigma = sigma0 * ones(size(size(in_img)));
    else
        sigma = sigma0;
    end
    if (size(size(in_img),2) ~= size(sigma,2))
        disp(['size(in_img) -> ' num2str(size(in_img))]);
        disp(['size(sigma)  -> ' num2str(size(sigma))]);
        disp(['     sigma   -> ' num2str(sigma)]);
        disp('Oops...  rank of the image must match the dimensions of sigma');
        error(help('gaussAnisof')); 
    end
    rank = size(size(in_img),2);
    if (~isa(in_img, 'double'))
        in_mat = double(in_img);
    else 
        in_mat = in_img;
    end

    lens = KERNEL_MULT * ceil(sigma);
    for q = 1:size(lens,2)
        if (lens(q) < 1)
            lens(q) = 1; end
    end
    prodLens = 1;
    for p = 1:rank
        prodLens = prodLens * lens(p);
    end
    h0 = zeros(prodLens, rank); % filter kernel with peak centered in the kernel's span   
    switch(rank)
        case 1
            h0 = h1d(lens, h0);
        case 2
            h0 = h2d(lens, h0);
        case 3
            h0 = h3d(lens, h0);
        case 4
            h0 = h4d(lens, h0);
        otherwise
            error(['oops...    gaussAnisof cannot support rank -> ' num2str(rank)]);
    end
    h1 = reshape(...
            gaussian(h0, zeros(1,rank), sigma),...
            lens);
    out_im = dip_image(imfilter(in_mat, h1));
    h1 = dip_image(h1);
    h0 = dip_image(h0);
    
    
    
% SUBFUNCTIONS
% passed h0 must contain a preallocated array

function h0 = h1d(lens, h0)
    for i = 1:lens(1)
        h0(i,:) = [i-lens(1)/2];
    end
    
function h0 = h2d(lens, h0)
    p     = 0;
    for j = 1:lens(2)
        for i = 1:lens(1)
            p = p + 1;
            h0(p,:) = [i-lens(1)/2 j-lens(2)/2];
        end
    end
    
function h0 = h3d(lens, h0)
    p     = 0;
    for k = 1:lens(3)
        for j = 1:lens(2)
            for i = 1:lens(1)
                p = p + 1;
                h0(p,:) = [i-lens(1)/2 j-lens(2)/2 k-lens(3)/2];
            end
        end
    end
    
function h0 = h4d(lens, h0)
    p     = 0;
    for m = 1:lens(4)
        for k = 1:lens(3)
            for j = 1:lens(2)
                for i = 1:lens(1)
                    p = p + 1;
                    h0(p,:) = [i-lens(1)/2 j-lens(2)/2 k-lens(3)/2 m-lens(4)/2];
                end
            end
        end
    end
    

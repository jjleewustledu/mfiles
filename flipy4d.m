function image_out = flipy4d(image_in)

%FLIPY4D flips input images from y>0 to y<0;
%        input images may be a double or dip_image object
%
%   Usage:  image_out = flipy4d(image_in)
%
%   Author:  John J. Lee 
%__________________________________________________________

% check validity of inputs

if (~isa(image_in, 'double') & ~isa(image_in, 'dip_image'))
    error('flipy4d only supports objects of type double or dip_image'); end    
sizes = size(image_in);
ranks = size(sizes);
if (~((1 <= ranks(2)) & (ranks(2) <= 4)))
    error('flipy4d only supports objects of rank 1 - 4'); end
    
% convert everything to dip_image objects of 4rh rank

dip4rank = newim(size(image_in,1), size(image_in,2), size(image_in,3), size(image_in,4));
image_in = dip_image(image_in);
sizes = size(image_in);
ranks = size(sizes);
switch ranks(2)
    case 1
        dip4rank(:,0,0,0) = image_in;
    case 2
        dip4rank(:,:,0,0) = image_in;
    case 3
        dip4rank(:,:,:,0) = image_in;
    case 4
        dip4rank = image_in;
    otherwise
        error('flipy4d.switch only supports dip_image objects of rank 1 - 4');
end
 
% form image_out

sizes     = size(dip4rank);
image_out = newim(sizes(1), sizes(2), sizes(3), sizes(4));
buffer    = zeros(sizes(1), sizes(2));
buffer2   = zeros(sizes(1), sizes(2));

for m = 0:sizes(4)-1
    for l = 0:sizes(3)-1
        % do some index arithmetic in double objects
        buffer(:,:) = double(dip4rank(:,:,l,m));
        for k = 1:sizes(2)
            for j = 1:sizes(1)
                buffer2(sizes(2)+1-k,j) = buffer(k,j);
            end
        end
        image_out(:,:,l,m) = dip_image(buffer2(:,:));
    end
end


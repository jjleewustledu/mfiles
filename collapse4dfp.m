function image_out = collapse4dfp(image_in)

sizes = size(image_in);
dim1 = sizes(1);
dim2 = sizes(2);
dim3 = sizes(3);
dimt = sizes(4);
norm = dim1*dim2*dim3;

image_in = double(image_in);
image_out = zeros(dimt,1);

for t = 1:dimt
    accum = 0;
    for z = 1:dim3
        for y = 1:dim2
            for x = 1:dim1
                accum = accum + image_in(x,y,z,t);
            end
        end
    end
    image_out(t) = accum/norm;
end

image_out = dip_image(image_out);
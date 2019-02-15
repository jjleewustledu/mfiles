function masks = T1_fcm(theDipData, num_clusters)

max_iters = 200;

dipSizes = size(theDipData);
sizes    = size(double(theDipData));
intData  = reshape(double(theDipData), [prod(sizes) 1]);

[center, U, obj_fun] = fcm(intData, num_clusters, max_iters);
maxU = max(U);
disp('size U -> ');
size(U)

masks = newim([dipSizes num_clusters]);
disp('size masks -> ');
size(masks)

for c = 1:num_clusters
    masks(:,:,:,:,c-1) = dip_image(reshape(U(c,:) == maxU, [sizes 1]), 'uint8');
end

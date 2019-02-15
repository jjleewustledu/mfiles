function synthEpi = sumICAmaps(map)

mapSizes = size(map);
synthEpi = newim(mapSizes(1), mapSizes(2), 1, 1);
Ncomps   = mapSizes(3);

%%%switches = [ 1 0 1 1 0 0 1 0 1 0 ];
switches = [ 1 1 1 1 1 1 1 1 1 1 ];
%%%switches = [ 1 0 0 0 0 0 0 0 0 0 ];

slice = newim(mapSizes(1), mapSizes(2));
for c = 0:Ncomps-1
    if (switches(c+1)) 
        slice = slice + squeeze(map(:,:,c)).*squeeze(map(:,:,c));
    end
end
synthEpi(:,:,0,0) = slice(:,:);


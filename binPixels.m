
function imageOut = binPixels(imageIn)

disp('version 7/28/2004');

CLUST_LEN  = 8; % to match PET voxel sizes
disp(['binning data in ' num2str(CLUST_LEN) ' X ' num2str(CLUST_LEN) ' squares']);

inSize = size(imageIn);
width_ = inSize(1);
height_ = inSize(2);
width2_ = floor(width_/CLUST_LEN);
height2_ = floor(height_/CLUST_LEN);
imageOut = newim(width2_, height2_, 1);

disp('building binned image; please wait...');

tic
for m2 = 0:(height2_ - 1)
    for n2 = 0:(width2_ - 1)
        accum = 0;
        for binm = 0:CLUST_LEN - 1
            for binn = 0:CLUST_LEN - 1
                m = m2*CLUST_LEN + binm;
                n = n2*CLUST_LEN + binn;
                accum = accum + imageIn(n,m,0);                    
            end 
        end 
        imageOut(n2,m2,0) = accum/(CLUST_LEN^2);     
    end 
end
toc

% SLOWER BY x2+
% -------------------------------------------------
% for m2 = 0:(height2_ - 1)
%     for n2 = 0:0 % (width2_ - 1)
%         template = newim(width_, height_, 1);
%         template((n2*CLUST_LEN):(((n2 + 1)*CLUST_LEN) - 1), (m2*CLUST_LEN):((m2 + 1)*CLUST_LEN - 1), 0) = 1;      
%         imageOut(n2,m2,0) = sum(template*imageIn)/(CLUST_LEN^2);     
%     end 
% end

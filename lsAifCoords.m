% Usage:  lsAifCoords(img, numexpected)
%         img         -> 4dfp dipimage object
%         numexpected -> # of AIFs to scan for

function lsAifCoords(img, numexpected)

sz = size(img);
dim1 = sz(1);
dim2 = sz(2);
dim3 = sz(3);
dim4 = sz(4);

count = 0;
for m = 0:dim4 - 1
    for k = 0:dim3 - 1
        for j = 0:dim2 - 1
            for i = 0:dim1 - 1
                if (img(i,j,k,m)) 
                    disp(['found aif at [' num2str(i) ' ' num2str(j) ' ' num2str(k) ' ' num2str(m) ']']);
                    count = count + 1;
                    if (count >= numexpected) break; end
                end
            end
            if (count >= numexpected) break; end
        end
        if (count >= numexpected) break; end
    end
    if (count >= numexpected) break; end
end
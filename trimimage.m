%TRIMIMAGE
% trims the 4dfp dipimage image read from filename to 
% image(x0:x1,y0:y1,z0:z1,t0:t1), and returns the new dipimage as 
% trimmed.   Index limits x0, x1, ... follow dipimage conventions.
%
% size(trimmed) = [x1-x0+1 y1-y0+1 z1-z0+1 t1-t0+1]
%
% USAGE:
%  trimmed = trimimage(filename, x0, x1, y0, y1, z0, z1, t0, t1)
%________________________________________________________________

function trimmed = trimimage(filename, x0, x1, y0, y1, z0, z1, t0, t1)

dimx = x1 - x0 + 1;
dimy = y1 - y0 + 1;
dimz = z1 - z0 + 1;
dimt = t1 - t0 + 1;

deltat = 10; % num. timeframes to read at a time
             % adjust empirically to match memory requirements
tloops = floor(dimt/deltat);
tremain = mod(dimt, deltat);

disp(['deltat = ' num2str(deltat)]);
disp(['tloops = ' num2str(tloops)]);
disp(['tremain = ' num2str(tremain)]);

trimmed = newim(dimx, dimy, dimz, dimt);
for dt = 0:tloops-1
    image = newim(256,256,32,deltat);
    image = read4d(filename,'ieee-be','single',...
                   256,256,32,deltat,0,0, t0 + dt*deltat);
    trimmed(:,:,:, dt*deltat:(dt*deltat + deltat - 1)) = ...
        image(x0:x1, y0:y1, z0:z1, 0:(deltat - 1));
    clear image;
end

% assertion
if (t1 - tloops*deltat - t0 + 1 ~= tremain)
    error('trimimage:assert', ...
        ['Following the dt loops, the number of remaining time slices is '...
         num2str(t1 - tloops*deltat - t0 + 1) ...
         ', but tremain = ' num2str(tremain) '!']);
end

if (tremain > 0)
    image = read4d(filename,'ieee-be','single',...
                   256,256,32,tremain,0,0, t0 + tloops*deltat); 
    trimmed(:,:,:, tloops*deltat:t1) = ...
        image(x0:x1, y0:y1, z0:z1, 0:tremain-1);
end




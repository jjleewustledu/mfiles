%RESHAPE_4DFP
%  reshapes 4dfp dipimage objects, especially for input images which have
%  x-y-slices which themselves comprise montages of x-y-slices.  
%
%  Usage:  imgOut = reshape_4dfp(imgIn, shape)
%          
%          imgOut, imgIn -> 4dfp dipimage objects
%          shape         -> row vector of target dimensions;
%                           the product of dimensions must be conserved
%                           between imgIn and imgOut
%_______________________________________________________________________

function imgOut = reshape_4dfp(imgIn, shape)

[dimx0 dimy0 dimz0 dimt0] = size(imgIn);
dimx = shape(1); dimy = shape(2); dimz = shape(3); dimt = shape(4);
disp(['image input has dimensions [' num2str(dimx0) ' ' num2str(dimy0) ' ' num2str(dimz0) ' ' num2str(dimt0) ']']);

if (dimx0*dimy0*dimz0*dimt0 ~= dimx*dimy*dimz*dimt)
    error('product of dimensions of imgIn was inconsistent with the requested shape'); end

facx = dimx0/dimx;
facy = dimy0/dimy;
facz = dimz0/dimz;
fact = dimt0/dimt;
if (facx < 1)
    error('reshape_4dfp currently does not support dimx0 < dimx'); end
if (facy < 1)
    error('reshape_4dfp currently does not support dimy0 < dimy'); end
if (fact ~= 1)
    error('reshape_4dfp currently does not support dimt0 ~= dimt'); end
if (mod(dimx0, dimx) > 0 & mod(dimx, dimx0) > 0)
    error('requested shape dimx is inconsistent with original dimx0'); end
if (mod(dimy0, dimy) > 0 & mod(dimy, dimy0) > 0)
    error('requested shape dimy is inconsistent with original dimy0'); end
if (mod(dimz0, dimz) > 0 & mod(dimz, dimz0) > 0)
    error('requested shape dimz is inconsistent with original dimz0'); end

imgOut = newim(dimx, dimy, dimz, dimt);
if (facz < 1)
    tmp = newim(dimx*facx, dimy*facy);
    for t = 0:dimt-1
            for y = 0:facy-1
                for x = 0:facx-1
                    tmp = squeeze(imgIn(:,:,0,t));
                    % scan left->right, then top->down
                    imgOut(:,:, x + facy*y, t) = ...
                        tmp((x*dimx):((x+1)*dimx-1), (y*dimy):((y+1)*dimy-1));
                end
            end
    end
else
    tmp = newim(dimx*facx, dimy*facy, dimz*facz);
    for t = 0:dimt-1
        for z = 0:facz-1
            for y = 0:facy-1
                for x = 0:facx-1
                    tmp = squeeze(imgIn(:,:,:,t));
                    imgOut(:,:,:, t) = ...
                        tmp((x*dimx):((x+1)*dimx-1), (y*dimy):((y+1)*dimy-1), (z*dimz):((z+1)*dimz-1));
                end
            end
        end
    end
end

disp(['image output has dimensions [' num2str(dimx) ' ' num2str(dimy) ' ' num2str(dimz) ' ' num2str(dimt) ']']);

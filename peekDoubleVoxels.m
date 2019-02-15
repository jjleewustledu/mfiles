% PEEKDOUBLEVOXELS
%
% Usage:	dblVxls = peekDoubleVoxels(roi, img)
%
%           dblVxls is a double col vector containing all voxels selected by roi
%			roi, img are dip_image or double objects
%
% Notes:	internal arithmetic is done with Matlab doubles
%
%________________________________________________________________________

function dblVxls = peekDoubleVoxels(roi, img)

    % check inputs ------------------------------------------------------
    
    switch(nargin)
        case 2
        otherwise
            error(help('peekDoubleVoxels'));
    end
    if (isa(roi, 'dip_image'))
        roi = double(roi);
    end
    if (isa(img, 'dip_image'))
        img = double(img);
    end
    if (~isa(roi, 'double') | ~isa(img, 'double'))
        error('NIL:peekDoubleVoxels:UnrecognizedParamTypeErr', help('peekDoubleVoxels'));
    end
    assert(size(roi,1) == size(img,1));
    assert(size(roi,2) == size(img,2));
    assert(size(roi,3) == size(img,3));
    %%% assert(size(size(roi)) == size(size(img)));

    % clean inputs, tabulate output vector -------------------------------
    
    %msk_eps   = (abs(img) < eps) & roi; % ignore img values that are zero
    %roi       = roi & ~msk_eps;
    
    idx = 0;
    switch size(size(img), 2)
        case {1,2}
            dblVxls = zeros(sum(sum(roi)), 1);
            [dimx dimy] = size(img);
            for y = 1:dimy
                for x = 1:dimx
                    if (roi(x,y))
                        idx = idx + 1;
                        dblVxls(idx,1) = img(x,y);
                    end 
                end
            end
        case 3  % use fast sums to decide whether to do deeper loops 
            dblVxls = zeros(sum(sum(sum(roi))), 1);
            [dimx dimy dimz] = size(img);
            for z = 1:dimz
                if (sum(sum(roi(:,:,z))) > eps)
                    for y = 1:dimy
                        for x = 1:dimx
                            if (roi(x,y,z))
                                idx = idx + 1;
                                dblVxls(idx,1) = img(x,y,z);
                            end 
                        end
                    end
                else
                    % disp(['roi has all zeros in slice ' num2str(z)]);
                end
            end
        case 4 % use fast sums to decide whether to do deeper loops 
            dblVxls = zeros(sum(sum(sum(sum(roi)))), 1);
            [dimx dimy dimz dimt] = size(img);
            for t = 1:dimt
                if (sum(sum(sum(roi(:,:,:,t)))) > eps)
                    for z = 1:dimz
                        if (sum(roi(:,:,z,t)) > eps)
                            for y = 1:dimy
                                for x = 1:dimx
                                    if (roi(x,y,z,t))
                                        idx = idx + 1;
                                        dblVxls(idx,1) = img(x,y,z,t);
                                    end
                                end
                            end
                        else
                            % disp(['roi has all zeros in slice ' num2str(z)]);
                        end
                    end
                else
                    % disp(['roi has all zeros in time-frame ' num2str(t)]);
                end
            end
        otherwise
            error(['oops...  peekDoubleVoxels cannot manage img size -> ' num2str(size(size(img)))]);
    end

    % forcing free memory
    clear roi;
    clear img;

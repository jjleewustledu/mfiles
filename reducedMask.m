% REDUCEDMASK
%
% Usage:    rmsk =  reducedMask(msk, slices, samplingInterval, samplingOffset)
%
%                   msk              -> original mask
%                   rmsk             -> new mask with less coverage than msk
%                   slices           -> double row vector of slices to keep from msk
%                   samplingInterval -> (option) integer > 1;
%                                       rmsk will have 1/samplingInterval the coverage of msk
%                   samplingOffet    -> (option) must be less than samplingInterval;
%                                       useful for separating msk into a samplingInterval number of
%                                       submsks
%
% See also:   dip_image
%

function rmsk = reducedMask(msk, slices, samplingInterval0, samplingOffset0)

    % checking inputs -----------------------------------------------------------------------------
    
    samplingInterval = 1;
    samplingOffset   = 0;
    switch (nargin)
        case 2
        case 3
            samplingInterval = samplingInterval0;
        case 4
            samplingInterval = samplingInterval0;
            samplingOffset   = samplingOffset0;
        otherwise
            error(help('reducedMask'));
    end
    if (size(size(msk),2) > 3)
        if (size(msk,4) > 1)
            error('reducedMask:  only 3D masks are supported at this time'); end
    end
    if (size(size(slices),2) > size(msk,3))
        error(['reducedMask:  too many slices were specified -> ' num2str(size(slices,2))]); end
    if (~strcmp(class(msk), 'dipimage'))
        msk = dip_image(squeeze(msk)); end
    
    % object creation ---------------------------------------------------------------
    
    rmsk     = newim(size(msk));
    tmpslice = newim(size(msk,1), size(msk,2));
    slimit   = size(msk,3) - 1;
    for r = 1:size(slices)
        s = slices(r);
        if (s > slimit)
            error(['reducedMask:   s -> ' num2str(s) 
                   ' exceeded the indices of available slices in the original mask, ' 
                   num2str(slimit)]); end 
        cnt = samplingOffset;
        for i = 0:size(msk,1)-1
            for j = 0:size(msk,2)-1
                if (msk(i,j,s))
                    cnt = cnt + 1; 
                    if (mod(cnt, samplingInterval) < eps)
                        tmpslice(i,j) = msk(i,j,s); end
                end
            end
        end
        rmsk(:,:,s) = tmpslice(:,:);
    end
        

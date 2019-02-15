%
% Usage:    msks_out = makeMasksMutuallyExclusive(msks_in)
%
%           msks_in:   cell-array of dipimages, {mask1 mask2 mask3 ...}
%
% NB:       overlap between msks_in{n-1} and msks_in{n} is kept in msks_out{n-1},
%           viz., mask index ranks volume of overlaps in decreasing order
%________________________________________________________________________________

function msks_out = makeMasksMutuallyExclusive(msks_in)

    NN = size(msks_in,2);
    disp(['makeMasksMutuallyExclusive:  received cell-array containing ' num2str(NN) ' masks']);
    for m = 1:NN
        if (~isa(msks_in{m}, 'dip_image'))
            error(['oops!   class of input cell at ' num2str(m) ' was ' class(msks_in{m})]); end
    end
    msks_out = msks_in; % in case 1 == NN
    if (NN > 1)
        accum = newim(size(msks_out{1})) > eps; % initialize all false
        for n = NN:-1:2
            overlap    = msks_out{n-1} & msks_out{n};                
            sumOverlap = sum(overlap);
            if (sumOverlap > 0)
                disp(['overlap of mask{' num2str(n-1) '} and mask{' num2str(n) '} was ' num2str(sumOverlap)...
                      '; moving intersecting volume into mask{' num2str(n-1) '}']); 
                msks_out{n-1} = msks_out{n-1}  |  overlap;
                msks_out{n}   = msks_out{n}    & ~overlap;
            end
            accum             = accum         |  msks_out{n};
            msks_out{n-1}     = msks_out{n-1} & ~accum;
        end
    end
    
    % sanity-check
    
    if (NN > 1)
        for m = 1:NN
            for n = 1:m
                if (m ~= n)
                    checksum = sum(msks_out{m} & msks_out{n});
                    if (checksum > 0)
                        error(['makeMasksMutuallyExclusive:  masks overlap at indices ' ...
                           num2str(m) ' and ' num2str(n) '; checksum -> ' num2str(checksum)]); end
                end
            end
        end
    end
        
    

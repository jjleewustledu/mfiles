% OSTERGAARDAIFS 
% follows the prescriptions described in Mouridson, Christensen, Gyldensted and Ostergaard,
% "Auto-selection of AIFs by Cluster Analysis", MRM 55, 524 (2006)
% 
%   Usage:  aifs = OstergaardAIFs( epi, mask, Hct )
%
%           epi         -> EPI data in 4dfp dipimage or double format
%           mask        -> spatial mask of the EPI data,
%                          expressed in 4dbool/4dfp dipimage or double format
%                          (OPTIONAL)
%           Hct         -> patient's hematocrit, expressed as a fraction [0, 1]
%                          normal female:  0.40 +/- 0.04
%                          normal male:    0.46 +/- 0.04
%                          (OPTIONAL)
%
%           aifs.coords -> collection of 4dfp dipimage coords
%           aifs.magn   -> collection of AIFs expressed as detected magnetization
%           aifs.concs  -> collection of AIFs expressed as concentration time curves
%   
%__________________________________________________________________________

function aifs = OstergaardAIFs( epi, mask, Hct )

    CUTOFF = 0; % for clusterdata(...) below

    epi = ensure_dip4dfp(epi);
    [dimx dimy dimz dimt] = size(epi);
    epi = reshape(epi, [dimx*dimy*dimz dimt]);

    mepi;
    if (nargin >= 2) % use mask
        mask = ensure_dip4dfp(
            ensure_dip4dbool(mask));
        mask = reshape(mask, dimx*dimy*dimz);
        mepi = newim(sum(mask), dimt);
        for t = 0:dimt
            for i = 0:dimx*dimy*dimz
                if (abs(mask(i)) > 0)
                    mepi(i,t) = epi(i,t);
                end
            end
        end
    else % no mask available
        mepi = epi;    
    end
    clear epi;

    % cf. statistical toolbox.
    % T is a vector of size m containing a cluster number for each observation.
    T = clusterdata(mepi, CUTOFF, 'criterion', 'distance', 'distance', 'euclidean');

    aifs.coords = ;
    aifs.magn = ;
    aifs.conc = ;


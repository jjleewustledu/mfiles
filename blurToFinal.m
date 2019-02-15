%
%   Usage:  [petblur mrblur] = blurToFinal(finalFwhh, petmmppix, mrmmppix)
%                            = blurToFinal(5.5168, 2.086344, 0.9375)
%
%                  finalFwhh -> 0 or greater
%                  petmmppix -> optional, defaults to 0.9375
%                  mrmmppix  -> optional, defaults to 0.9375
%

function [petblur mrblur] = blurToFinal(finalFwhh, petmmppix, mrmmppix)
    
    ZOOM = 0; % bore periphery

    switch (nargin)
        case 0
            finalFwhh = 0;
            petmmppix = 0.9375;
            mrmmppix  = 0.9375;
        case 1
            petmmppix = 0.9375;
            mrmmppix  = 0.9375;
        case 2
            petmmppix = 0.9375;
        case 3
        otherwise
            error(help('blurToFinal'));
    end
    
    % SIMPLE SEARCH BY DECIMAL PRECISION
    
    petPs = fwhh_petPointspread(0, ZOOM, petmmppix);
    if (finalFwhh <= petPs)
        petblur = 0;
        mrblur  = petPs;
        disp(['finalFwhh must be as least ' num2str(petPs) ' mm']);
        return;
    else        
        petblur = inc_petblur(0, 1);
        petblur = inc_petblur(petblur, 0.1);
        petblur = inc_petblur(petblur, 0.01);
        petblur = inc_petblur(petblur, 0.001);
        petblur = inc_petblur(petblur, 0.0001);
        mrblur  = max(finalFwhh, max(fwhh_mrPointspread(finalFwhh, mrmmppix)));       
    end
    
    % NESTED FUNCTION INC_PETBLUR
    
    function petblurLast = inc_petblur(petblur, inc)     
        petblurLast = petblur;
        petFinal    = fwhh_petPointspread(petblur, ZOOM, petmmppix);
        while (petFinal < finalFwhh)
            petblurLast = petblur;
            petblur     = petblur + inc;
            petFinal    = fwhh_petPointspread(petblur, ZOOM, petmmppix);
        end
    end

end
    

    
    
    
    
    

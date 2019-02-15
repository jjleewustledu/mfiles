% 
%   Usage:  vecout = embedInVector(vecin, dim)
%
%           vecin  -> scalar or row-vector $\in R^{\text{d}} | d <= dim$ 
%           vecout ->           row-vector $\in R^{\text{dim}}$
%____________________________________________

function vecout = embedInVector(vecin, dim)

    vecout = zeros(1, dim);
    
    for d = 1:dim
        if (d <= size(vecin,2))
            vecout(d) = vecin(d);
        else
            vecout(d) = vecin(size(vecin,2));
        end
    end
    
    

    

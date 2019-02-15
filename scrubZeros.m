function vout = scrubZeros(vin)
%% SCRUBZEROS ... 
%   
%  Usage:  vec_out = scrubZeros(vec_in) 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 

vin = double(vin);
assert(length(size(vin)) <= 2);
assert(size(vin,1) == 1 || size(vin,2) == 1);

Nz  = sum(0 == vin);
if (Nz > 0)
    vout = zeros(1,length(vin)-Nz);
    a1   = 0;
    for a = 1:length(vin) %#ok<FORFLG,*PFUNK>
        if (vin(a) ~= 0)
            a1 = a1 + 1;
            vout(a1) = vin(a); %#ok<*PFPIE>
        end
    end
    assert(a1 == length(vin) - Nz);
else
    vout = vin;
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/scrubZeros.m] ======  

%COUNTS_TO_CBF converts a dipimage object containing counts from an ECAT HR
%EXACT scanner and applied the quadratic Herscovitch as well as exponential
%Herscovitch corrections.
%
% Usage:  outimage = counts_to_CBF(inimage, aflow1, bflow1, use_videen87, use_hersc87)
%                                           double  double  bool          bool
%
% Herscovitch P, Markham J, Raichle ME. 
% Brain blood flow measured with intravenous H2(15)O: I. theory and error analysis.
% J Nucl Med 1983;24:782–789
%
% Videen TO, Perlmutter JS, Herscovitch P, Raichle ME. 
% Brain blood volume, blood flow, and oxygen utilization measured with
% O-15 radiotracers and positron emission tomography: revised metabolic computations. 
% J Cereb Blood Flow Metab 1987;7:513–516
%
% Herscovitch P, Raichle ME, Kilbourn MR, Welch MJ. 
% Positron emission tomographic measurement of cerebral blood flow and
% permeability: surface area product of water using [15O] water and [11C] butanol. 
% J Cereb Blood Flow Metab 1987;7:527–542

function outimage = counts_to_CBF(inimage, aflow1, bflow1, use_videen87, use_hersc87)

MAX = 1.0e12;
MIN = -1.0e12;

if (use_videen87)
    cbf = inimage*(aflow1*inimage + bflow1);
else
    cbf = inimage;
end

if (use_hersc87)
    try
        sz   = size(cbf);
        tmp  = zeros(sz(2), sz(1), sz(3), sz(4));
        tmp  = double(cbf);
        tmp2 = zeros(sz(2), sz(1), sz(3), sz(4));
    catch
        sz           = size(cbf);
        sz(4)        = 1;
        tmp          = zeros(sz(2), sz(1), sz(3), sz(4));
        tmp(:,:,:,1) = double(cbf);
        tmp2         = zeros(sz(2), sz(1), sz(3), sz(4));
    end
    %%%warning off MATLAB:divideByZero;
    for m = 1:sz(4)
        for k = 1:sz(3)
            for j = 1:sz(1)
                %%%disp(['processing row ' num2str(j)]);
                for i = 1:sz(2)
                    tmp2(i,j,k,m) = tmp(i,j,k,m)/(1 - exp(-1.5 - 20.6/tmp(i,j,k,m)));
                    if (~isfinite(tmp2(i,j,k,m)) | tmp2(i,j,k,m) > MAX | tmp2(i,j,k,m) < MIN)
                        disp(['non-finite value at [' num2str(i) ' ' num2str(j) ' '...
                                num2str(k) ' ' num2str(m) ']']);
                        tmp2(i,j,k,m) = 0;
                    end
                end
            end
        end
    end
    outimage = dip_image(tmp2);
else
    outimage = dip_image(cbf);
end

return;

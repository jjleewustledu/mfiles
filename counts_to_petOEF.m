% COUNTS_TO_PETOEF
%
% Usage:  oef = counts_to_petOEF(counts, w, a, cbf, IntegralCa, cbv)
%
%         oef       -> dip_image or double
%         counts    -> dip_image or double, PET$_{\text{obs}}$ from O$^{15}$O study
%         w         -> factor to convert PET counts/pixel to well counts/mL (PETT Conversion Factor)
%         a         -> [a1 a2 a3 a4] constants in quadratic equations
%                       a1 from water A
%                       a2 from water B
%                       a3 from O2 A
%                       a4 from O2 B
%         cbf       -> dip_image or double
%         IntegralCa-> \int_{T_1}^{T_2} C_{a}^{O_{2}}(t) dt
%         Iintegral -> (D $\cdot$ R/100) $\cdot$ \int_{T_1}^{T_2} C_{a}^{O_{2}}(t) dt
%         cbv       -> dip_image or double
%
%       Herscovitch P, Markham J, Raichle ME. Brain blood flow measured
% with intravenous H2(15)O: I. theory and error analysis.
% J Nucl Med 1983;24:782ñ789
%       Videen TO, Perlmutter JS, Herscovitch P, Raichle ME. Brain
% blood volume, blood flow, and oxygen utilization measured with
% O-15 radiotracers and positron emission tomography: revised metabolic
% computations. J Cereb Blood Flow Metab 1987;7:513ñ516
%       Herscovitch P, Raichle ME, Kilbourn MR, Welch MJ. Positron
% emission tomographic measurement of cerebral blood flow and
% permeability: surface area product of water using [15O] water and
% [11C] butanol. J Cereb Blood Flow Metab 1987;7:527ñ542
%       Raichle ME, Martin WRW, Herscovitch P, Mintun MA, Markham J 
% (1983) Brain blood flow measured with intravenous H$_2^{15}$O.
% II. Implementation and validation. J Nucl Med 24:790-798
%

function oef = counts_to_petOEF(counts, pid, cbf, cbv) ...
   
    R         = 0.85; % mean ratio of small-vessel to large-vessel Hct
    D         = 1.05; % density of brain, g/mL
    Iintegral = D*R*modelIntegralCa(pid)/100;
    
    counts = squeeze(counts);
    w      = modelW(pid);
    a      = modelA(pid);
    o2cnts = modelIntegralO2Counts(pid);
    cbf    = squeeze(cbf);
    ICbv = R*(squeeze(cbv)*D/100)*o2cnts;
    % ICbv = Iintegral*cbv;
    oef    = (w * counts - (a(1)*cbf.*cbf + a(2)*cbf) - ICbv) ./ ...
             ((a(3)*cbf.*cbf + a(4)*cbf) - 0.835*ICbv);
  
    oef    = oef.*isfinite(oef);
    oef    = dip_image(squeeze(oef)).*(oef > eps & oef < 1);
    




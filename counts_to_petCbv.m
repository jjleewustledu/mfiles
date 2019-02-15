%
% Usage:  cbv = counts_to_petCbv(counts, pid)
%
%         cbv        -> dip_image or double matrix, max(cbv) = 1
%         counts     -> double matrix
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
%

function cbv = counts_to_petCbv(counts, pid)

    MAX_CBV = 1;
    R = 0.85; % mean ratio of small-vessel to large-vessel Hct
    D = 1.05; % density of brain, g/mL

    cbv = squeeze(counts * modelBVFactor(pid));
    % cbv = squeeze(MAX_CBV * modelW(pid) .* counts/(R * D * modelIntegralCa(pid)));


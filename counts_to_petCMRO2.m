% PETCMRO2
%
% Usage:  cmro2 = petCMRO2(oef, cbf, CaO2)
%
%         cmro2 -> dip_image or double
%         oef   -> dip_image or double
%         cbf   -> dip_image or double
%         CaO2  -> total oxygen content of arterial blood (all isotopes)
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

function cmro2 = counts_to_petCMRO2(oef, cbf, pid)
	
	cmro2 = oef .* cbf * modelOxygenContent(pid);


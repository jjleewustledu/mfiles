%COUNTS_TO_CBF converts a dipimage object containing counts from an ECAT HR
%EXACT scanner and applied the quadratic Herscovitch as well as exponential
%Herscovitch corrections.
%
% Usage:  outimage = counts_to_CBF(inimage, aflow1, bflow1)
%
%       Herscovitch P, Markham J, Raichle ME. Brain blood flow measured
% with intravenous H2(15)O: I. theory and error analysis.
% J Nucl Med 1983;24:782–789
%       Videen TO, Perlmutter JS, Herscovitch P, Raichle ME. Brain
% blood volume, blood flow, and oxygen utilization measured with
% O-15 radiotracers and positron emission tomography: revised metabolic
% computations. J Cereb Blood Flow Metab 1987;7:513–516
%       Herscovitch P, Raichle ME, Kilbourn MR, Welch MJ. Positron
% emission tomographic measurement of cerebral blood flow and
% permeability: surface area product of water using [15O] water and
% [11C] butanol. J Cereb Blood Flow Metab 1987;7:527–542

function outimage = counts_to_CBF_0(inimage, aflow1, bflow1)

MAX = 1.0e12;
MIN = -1.0e12;

outimage = inimage*(aflow1*inimage + bflow1);

function counts = printTsc(label, times, taus, counts, mask)
%% PRINTTSC ... 
%   
%  Usage:  printTsc(label, times, taus, counts, mask) 
%                   ^ string
%                          ^      ^ 1xN double
%                                       ^ double, PETcnts
%                                               ^ boolean NIfTI
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

Nf = min([length(times) length(taus) length(counts)]);
PIE = 4.88; % 3D [11C] scans from 2012
fprintf('printTsc:  using pie->%f\n', PIE);
Npixels = mask.dipsum;

% \pi \equiv \frac{wellcnts/cc/sec}{PETcnts/pixel/min}
% wellcnts/cc = \pi \frac{PETcnts}{pixel} \frac{sec}{min}

counts = PIE * (counts/Npixels) * 60;
fprintf('%s\n', label);
fprintf('    %i,    %i\n', Nf, 3);
for f = 1:Nf
    fprintf('%12.1f %12.1f %14.2f\n', times(f), taus(f), counts(f));
end
fprintf('\n\n');








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/printTsc.m] ======  

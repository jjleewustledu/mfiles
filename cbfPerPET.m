function [cbf,minf,maxf] = cbfPerPET(flow, roi)
%% CBFPERPET returns the mean, min, max of PET CBF, 20 mL/min/100g, for a given roi
%   
%  Usage:  cbf = cbfPerPET(flow, roi) 
%          ^               ^ NIfTI x2
%          double, physiologic scaling
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 
import mlfourd.*;
assert(isa(flow,  'mlfourd.INIfTI'));
assert(isa(roi,   'mlfourd.INIfTI'));
assert(dipmax(  roi) <= 1);

fnii   = roi .* flow;
fniib  = NiiBrowser(fnii);
cbf    = fnii.dipsum ./ roi.dipsum;

assert(cbf > 0);
minf   = min(fniib.sampleVoxels);
maxf   = max(fniib.sampleVoxels);




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/cbfPerWhiteMatter.m] ======  

function [cbf,minf,maxf] = cbfPerWhiteMatter(flow, roi, wmroi)
%% CBFPERWHITEMATTER rescales flow measurements within a specified roi with the flow in a specified white-matter roi
%                    assumed to be 20 mL/min/100g
%   
%  Usage:  cbf = cbfPerWhiteMatter(flow, roi, wmroi) 
%          ^                       ^ NIfTI x3
%          double, physiologic scaling
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 
import mlfourd.*;
WMCBF = 20;
assert(isa(flow,  'mlfourd.INIfTI'));
assert(isa(roi,   'mlfourd.INIfTI'));
assert(isa(wmroi, 'mlfourd.INIfTI'));
%assert(dipmin( flow) >= 0);
assert(dipmax(  roi) <= 1);
assert(dipmax(wmroi) <= 1);

fnii   = roi .* flow;
fniib  = NiiBrowser(fnii);
f      =   fnii.dipsum ./   roi.dipsum;
wmfnii = wmroi .* flow;
wmf    = wmfnii.dipsum ./ wmroi.dipsum;

%assert(  f > 0);
%assert(wmf > 0);

cbf    = WMCBF .* f  / wmf;
minf   = WMCBF .* min(fniib.sampleVoxels) / wmf;
maxf   = WMCBF .* max(fniib.sampleVoxels) / wmf;




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/cbfPerWhiteMatter.m] ======  

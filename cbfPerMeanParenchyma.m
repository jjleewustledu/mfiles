function [cbf,f,parenf] = cbfPerMeanParenchyma(flow, roi, paren)
%% CBFPERWHITEMATTER ... 
%   
%  Usage:  cbf = cbfPerMeanParenchyma(flow, roi, paren) 
%          ^                          ^ NIfTI
%          double, relative to paren
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 


%assert(dipmin( flow) >= 0);
assert(dipmax(  roi) <= 1);
assert(dipmax(paren) <= 1);

fimg   =   roi.img .* flow.img;
f      =   sum(sum(sum(fimg))) ./ roi.dipsum;
parenfimg = paren.img .* flow.img;
parenf    = sum(sum(sum(parenfimg))) ./ paren.dipsum;

%assert(  flow > 0);
%assert(parenflow > 0);

cbf    = f / parenf;





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/cbfPerWhiteMatter.m] ======  

function [gluc1b, gluc1sumt] = temp(gluc1, gluc1mask)
%% TEMP ... 
%   
%  Usage:  temp() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.5.0.197613 (R2015a) 
%% $Id$ 

import mlpet.* mlfourd.*;
assert(isa(gluc1, 'mlfourd.INIfTI'));
gluc1b = gluc1.component; 
gluc1b.img = gluc1.activity; 
gluc1sumt = DynamicNIfTId(gluc1b, 'timeSum', true);

gluc1sumt = MaskingNIfTId(gluc1sumt, 'niftid_mask', gluc1mask);



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/temp.m] ======  

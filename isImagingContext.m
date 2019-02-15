function tf = isImagingContext(obj)
%% ISIMAGINGCONTEXT ... 
%  Usage:  tf = isImagingContext(object) 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

tf = isa(obj, 'mlfourd.ImagingContext') || ...
     isa(obj, 'mlpet.PETImagingContext') || ...
     isa(obj, 'mlmr.MRImagingContext');








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/isImagingContext.m] ======  

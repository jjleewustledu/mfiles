function buildMetab()
%% BUILDMETAB ... 
%  Usage:  buildMetab() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.1.0.441655 (R2016b).  Copyright 2018 John Joowon Lee. 



cmro2 = mlfourd.NumericalNIfTId.load('cmro22_op_fdgv2r1.4dfp.hdr')
cmrglc = mlfourd.NumericalNIfTId.load('cmrglc_op_fdgv2r1.4dfp.hdr')
ogi = cmro2 ./ cmrglc; ogi.fileprefix = 'ogi'
ogi.filesuffix = '.4dfp.hdr'
ogi.save
agi = cmrglc - cmro2/6; agi.fileprefix = 'ogi'; agi.filesuffix = '.4dfp.hdr'
agi.fileprefix = 'agi';
agi
agi.save
cbv
cbv = mlfourd.NumericalNIfTId.load('cbv1_op_fdgv2r1.4dfp.hdr'); cbf = mlfourd.NumericalNIfTId.load('cbf1_op_fdgv2r1.4dfp.hdr'); oef = mlfourd.NumericalNIfTId.load('oef2_op_fdgv2r1.4dfp.hdr');
metab = cbv;
metab.img(:,:,:,2) = cbf.img;
metab.img(:,:,:,3) = oef.img;
metab.img(:,:,:,4) = cmro2.img;
metab.img(:,:,:,5) = cmrglc.img;
metab.img(:,:,:,6) = ogi.img;
metab.img(:,:,:,7) = agi.img;
metab
metab.size
metab.filename = 'metab_op_fdgv2r1.4dfp.hdr'
metab.save



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/buildMetab.m] ======  

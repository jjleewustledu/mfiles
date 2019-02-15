%
%  USAGE:  [cbv_overlay cbv] = peekCbv(pid, modality, roiMask, rgb)
%
%          pid: 		string of form 'vc4354' or the corresponding int index
%          				from pidList
%          modality:	string for modality; cf. getCbf
%          roiMask:		dip_image object 				(optional)
%          rgb:			triplet, e.g., [128 200 200] 	(optional)
%
%          cbv_overlay:	dip_image with overlaid roiMask
%          cbv:			dip_image
%
%  Created by John Lee on 2008-04-04.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function [cbv_overlay cbv] = peekCbv(pid, modality, roiMask, rgb)
	
	switch (nargin)
		case 2
            cbv = squeeze(getCbv(pid, modality));
			cbv_overlay = cbv;
		case 3
            cbv = squeeze(getCbv(pid, modality));
			cbv_overlay = overlay(cbv, squeeze(roiMask), DB('rgb'));
		case 4
            cbv = squeeze(getCbv(pid, modality));
			cbv_overlay = overlay(cbv, squeeze(roiMask), rgb);
		otherwise
			error(help('peekCbv'));
	end

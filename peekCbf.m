%
%  USAGE:  [cbf_overlay cbf] = peekCbf(pid, modality, roiMask, rgb)
%
%          pid: 		string of form 'vc4354' or the corresponding int index
%          				from pidList
%          modality:	string for modality; cf. getCbf
%          roiMask:		dip_image object 				(optional)
%          rgb:			triplet, e.g., [128 200 200] 	(optional)
%
%          cbf_overlay:	dip_image with overlaid roiMask
%          cbf:			dip_image
%
%  Created by John Lee on 2008-04-01.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function [cbf_overlay cbf] = peekCbf(pid, modality, roiMask, rgb)
	
	switch (nargin)
		case 2
            cbf = squeeze(getCbf(pid, modality));
			cbf_overlay = cbf;
		case 3
            cbf = squeeze(getCbf(pid, modality));
			cbf_overlay = overlay(cbf, squeeze(roiMask), DB('rgb'));
		case 4
            cbf = squeeze(getCbf(pid, modality));
			cbf_overlay = overlay(cbf, squeeze(roiMask), rgb);
		otherwise
			error(help('peekCbf'));
	end

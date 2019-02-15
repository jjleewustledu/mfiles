%
%  USAGE:  [mtt_overlay mtt] = peekMtt(pid, modality, roiMask, rgb)
%
%          pid: 		string of form 'vc4354' or the corresponding int index
%          				from pidList
%          modality:	string for modality; cf. getCbf
%          roiMask:		dip_image object 				(optional)
%          rgb:			triplet, e.g., [128 200 200] 	(optional)
%
%          mtt_overlay:	dip_image with overlaid roiMask
%          mtt:			dip_image
%
%  Created by John Lee on 2008-04-04.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function [mtt_overlay mtt] = peekMtt(pid, modality, roiMask, rgb)

	switch (nargin)
		case 2
            mtt = squeeze(getMtt(pid, modality));
			mtt_overlay = mtt;
		case 3
            mtt = squeeze(getMtt(pid, modality));
			mtt_overlay = overlay(mtt, squeeze(roiMask), DB('rgb'));
		case 4
            mtt = squeeze(getMtt(pid, modality));
			mtt_overlay = overlay(mtt, squeeze(roiMask), rgb);
		otherwise
			error(help('peekMtt'));
	end

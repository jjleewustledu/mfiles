%
%  USAGE:  [t1w_overlay t1w] = peekT1w(pid, roiMask, rgb)
%
%          pid: 	string of form 'vc4354' or the corresponding int index
%          			from pidList
%
%          roiMask:	dip_image object 			    (optional)
%          rgb:		triplet, e.g., [128 200 200] 	(optional)
%
%          t1w_overlay:	dip_image with overlaid roiMask
%          t1w:			dip_image
%
%  $Id$
%________________________________________________________________________

function [t1w_overlay t1w] = peekT1w(pid, roiMask, rgb)
	
	RGB = [10 100 100];
	
	switch (nargin)
		case 1
            t1w = squeeze(getT1w(pid));
			t1w_overlay = t1w;
		case 2
            t1w = squeeze(getT1w(pid));
			t1w_overlay = overlay(t1w, squeeze(roiMask), RGB);
		case 3
            t1w = squeeze(getT1w(pid));
			t1w_overlay = overlay(t1w, squeeze(roiMask), rgb);
		otherwise
			error(help('peekT1w'));
	end





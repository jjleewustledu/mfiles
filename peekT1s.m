%
%  DEPRECATED
%
%  USAGE:  [t1s,t1s_rois] = peekT1s(pid, rois)
%
%          pid is a string of form 'vc4354' or the corresponding int index
%          from pidList
%
%          (optional) rois is a binary dipimage object from peekRois
%
%  
%
%  $Id$
%________________________________________________________________________
function [t1s,t1s_rois] = peekT1s(pid, rois)

	disp('peekT1s is DEPRECATED; prefer peekT1w');
	t1s  = squeeze(getT1w(pid));
	if (nargin == 2)
		rois = squeeze(rois);
		t1s_rois = overlay(t1s, rois, [200 0 0]);
	end





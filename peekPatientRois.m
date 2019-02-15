%PEEKPATIENTROIS
%
%  USAGE:  [grey, basal, white, rois] = peekPatientRois(idx, kindImg)
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function [grey, basal, white, rois] = peekPatientRois(idx, kindImg)

pid = pidList(idx);
[grey, basal, white, rois] = peekRois(pid, 'allrois', 'dip', 0, excludeCsfRoi(kindImg));


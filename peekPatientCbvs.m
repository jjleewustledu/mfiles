%PEEKPATIENTCBVS
%
%  USAGE:  peekPatientCbvs(idx, kindImg)
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function peekPatientCbvs(idx, kindImg)

pid = pidList(idx);

[grey, basal, white, rois] = peekRois(pid, 'allrois', 'dip', 0, excludeCsfRoi(kindImg));

[cbvMlem, cbvOsvd, cbvSsvd, cbvBayes, oc1, oc1gauss] = ...
         peekCbvs(pid, slice1(idx), slice2(idx), ocFileList(idx), ...
         mlemTimes(idx, 'cbv'), osvdTimes(idx, 'cbv'), ssvdTimes(idx, 'cbv'), rois)

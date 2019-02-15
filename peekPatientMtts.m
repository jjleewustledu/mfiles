%PEEKPATIENTMTTS
%
%  USAGE:  peekPatientMtts(idx, kindImg)
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function peekPatientMtts(idx, kindImg)

pid = pidList(idx);

[grey, basal, white, rois] = peekRois(pid, 'allrois', 'dip', 0, excludeCsfRoi(kindImg));

[mttMlem, mttOsvd, mttSsvd, mttBayes, mtt1, mtt1gauss] = ...
         peekMtts(pid, slice1(idx), slice2(idx), ocFileList(idx), hoFileList(idx), ...
         mlemTimes(idx, 'mtt'), osvdTimes(idx, 'mtt'), ssvdTimes(idx, 'mtt'), rois)

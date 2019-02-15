%PEEKPATIENTCBFS
%
%  USAGE:
%  [cbfMlem,cbfOsvd,cbfSsvd,FBayes,ho1,ho1gauss,t1s,cbfSsvd_rois,FBayes_rois,ho1gauss_rois,t1s_rois] = 
%          peekPatientCbfs(idx, kindImg)
%          idx is an integer
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function [cbfMlem, cbfOsvd, cbfSsvd, FBayes, ho1, ho1gauss, t1s,...
          cbfSsvd_rois, FBayes_rois, ho1gauss_rois, t1s_rois] = peekPatientCbfs(idx, kindImg)

% exclude patients 2 & 12; missing ho

pid = pidList(idx);

[grey, basal, white, rois] = peekRois(pid, 'allrois', 'dip', 0, excludeCsfRoi(kindImg));
[t1s, t1s_rois] = peekT1s(pid, rois);

[cbfMlem, cbfOsvd, cbfSsvd, FBayes, ho1, ho1gauss,...
    cbfMlem_rois, cbfOsvd_rois, cbfSsvd_rois, FBayes_rois, ho1_rois, ho1gauss_rois] = ...
         peekCbfs(pid, bayesSlice1(idx), bayesSlice2(idx), hoFileList(idx), ...
         mlemTimes(idx, 'cbf'), osvdTimes(idx, 'cbf'), ssvdTimes(idx, 'cbf'), rois);
 % 
 %
 %

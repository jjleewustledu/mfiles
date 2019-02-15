% EXCLUDECSFROI indicates whether CSF should be excluded from any ROI-based calculations
%
% Usage:    bool = excludeCsfRoi(kindImg)
%
%           kindImg:  'ho1', 'bayesF', 'mlemF', etc.
%

function bool = excludeCsfRoi(kindImg)

    bool = ~(strcmp('ho1', kindImg) || ...
             strcmp('oc1', kindImg) || ...
             strcmp('oo1', kindImg));

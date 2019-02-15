%PEEKCOORDS
%
% Usage:  theCoords = peekCoords(kindRoi, kindImg, side, moment, white_matter_ref)
%
%         theCoords will be a vector of doubles, ordered ascending
%         kindRoi is 'grey', 'basal', 'white' or 'allrois'
%         kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd', 'cbv...', 'mtt...' or 'ho1' 
%         side    is 'ipsi', 'contra' -lateral to lesions, otherwise both sides
%         moment  is 0 (pop), 1 (mean) or 2 (stderr)
%         ref_tissue is a boolean, 0 or 1 (optional)
%________________________________________________________________

function theCoords = peekCoords(kindRoi, kindImg, side, moment, ref_tissue)

theCoords = peekCoords5(kindRoi, kindImg, side, moment, ref_tissue);

% peekCoords3 IS FIXED as of 2007sep12.

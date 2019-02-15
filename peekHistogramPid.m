%PEEKCOORDS
%
% Usage:  [binLocs, counts] = peekHistogramPid(pid, kindRoi, kindImg, side)
%
%         theCoords will be a vector of doubles, ordered ascending
%         kindRoi is 'grey', 'basal', 'white' or 'allrois'
%         kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd' or 'ho1' 
%         side    is 'ipsi', 'contra' -lateral to lesions, otherwise both sides
%
%         bar(binLocs, counts) plots the histogram
%________________________________________________________________

function [binLocs, counts, list, anRoi, theImg] = peekHistogramPid(p, kindRoi, kindImg, side)

[grey, basal, white, allRois] = peekRois(p, kindRoi, 'dip', 0, excludeCsfRoi(kindImg));

grey    = double(grey);
basal   = double(basal);
white   = double(white);
allRois = double(allRois);

if ~isnumeric(grey),    error(['grey{'    num2str(p) '} was not numeric']); end
if ~isnumeric(basal),   error(['basal{'   num2str(p) '} was not numeric']); end
if ~isnumeric(white),   error(['white{'   num2str(p) '} was not numeric']); end
if ~isnumeric(allRois), error(['allRois{' num2str(p) '} was not numeric']); end

sideRoi = ones(size(allRois));
if (strcmp('ipsi', side))
    sideRoi = roiIpsiLesion(p);
    disp('using hemisphere ipsilateral to lesions');
elseif (strcmp('contra', side))
    sideRoi = roiContraLesion(p);
    disp('using hemisphere contarlateral to lesions');
end

grey    = sideRoi .* grey    .* slicesCellArray([slice1(p)+1, slice2(p)+1], size(allRois));
basal   = sideRoi .* basal   .* slicesCellArray([slice1(p)+1, slice2(p)+1], size(allRois));
white   = sideRoi .* white   .* slicesCellArray([slice1(p)+1, slice2(p)+1], size(allRois));
allRois = sideRoi .* allRois .* slicesCellArray([slice1(p)+1, slice2(p)+1], size(allRois));

switch (kindRoi)
    case 'grey'
        anRoi = grey;
    case 'basal'
        anRoi = basal;
    case 'white'
        anRoi = white;
    otherwise
        anRoi = allRois;                                   
end

[cbfMlem, cbfOsvd, cbfSsvd, FBayes, ho1] = ...
        peekCbfs(pidList(p), slice1(p), slice2(p), ...
        hoFileList(p), mlemTimes(p, 'cbf'), osvdTimes(p, 'cbf'), ssvdTimes(p, 'cbf'), anRoi, kindImg, 0);

cbfMlem = double(cbfMlem);
cbfOsvd = double(cbfOsvd);
cbfSsvd = double(cbfSsvd);
FBayes  = double(FBayes);
ho1     = double(ho1);

if ~isnumeric(cbfMlem),  error(['cbfMlem for idx -> {'  num2str(idx) '} was not numeric']); end
if ~isnumeric(cbfOsvd),  error(['cbfOsvd for idx -> {'  num2str(idx) '} was not numeric']); end
if ~isnumeric(cbfSsvd),  error(['cbfSsvd for idx -> {'  num2str(idx) '} was not numeric']); end
if ~isnumeric(FBayes),   error(['FBayes for idx -> {'   num2str(idx) '} was not numeric']); end
if ~isnumeric(ho1),      error(['ho1 for idx -> {'      num2str(idx) '} was not numeric']); end

switch (kindImg)
    case 'F'
        theImg = FBayes;
    case 'cbfSsvd'
        theImg = cbfSsvd;
    case 'cbfOsvd' 
        theImg = cbfOsvd;
    case 'cbfMlem'
        theImg = cbfMlem;
    case 'ho1'
        theImg = ho1;
    otherwise
        error('peekCoords.kindImg was unrecognizable');
end

[binLocs, counts, list] = peekHistogram(anRoi, theImg);
anRoi  = dip_image(anRoi);
theImg = dip_image(theImg);



%SLICESCELLARRAY
%
% Usage:  maskSlices = slicesCellArray(sliceList, mskSizes)
%
%         maskSlices is a 3D Matlab array of doubles
%         sliceList is a row vector containing slice indices (ints)
%         mskSizes is a row vector containing the dims of the target mask
%
%________________________________________________________________

function maskSlices = slicesCellArray(sliceList, mskSizes)

if size(sliceList, 1) > 1, 
    error('peekCoords.slicesCellArray requires that sliceList be a row vector'); 
end
if size(mskSizes, 2) < 3,
    error('peekCoords.slicesCellArray requires mskSizes to be at least 3D');
end

NSLICES    = size(sliceList, 2);
maskSlices = zeros(mskSizes(1,1), mskSizes(1,2), mskSizes(1,3));
oneSlice   = ones (mskSizes(1,1), mskSizes(1,2));
for s = 1:mskSizes(1,3)
    for s1 = 1:NSLICES
        if s == sliceList(1,s1), maskSlices(:,:,s) = oneSlice; end
    end
end

    


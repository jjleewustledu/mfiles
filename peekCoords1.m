%PEEKCOORDS
%
% Usage:  theCoords = peekCoords(kindRoi, kindImg)
%
%         theCoords will be a vector of doubles, ordered ascending
%         kindRoi is 'grey', 'basal', 'white' or 'allrois'
%         kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd' or 'ho1' 
%________________________________________________________________

function [theCoords, theImgs, ...
          grey, basal, white, allRois] = peekCoords1(kindRoi, kindImg)

NPID = 19;

% gather ROIs, image data, and truncate ROIs by available slices

grey     = cell(NPID);
basal    = cell(NPID);
white    = cell(NPID);
allRois  = cell(NPID);
cbfMlem  = cell(NPID);
cbfOsvd  = cell(NPID);
cbfSsvd  = cell(NPID);
FBayes   = cell(NPID);
ho1      = cell(NPID);
ho1gauss = cell(NPID);

% cbfMlem_rois  = cell(NPID);
% cbfOsvd_rois  = cell(NPID);
% cbfSsvd_rois  = cell(NPID);
% FBayes_rois   = cell(NPID);
% ho1_rois      = cell(NPID);
% ho1gauss_rois = cell(NPID);

for p = 1:NPID
    [grey{p}, basal{p}, white{p}, allRois{p}] = peekRois(p, kindRoi);
    
    grey{p}    = double(grey{p});
    basal{p}   = double(basal{p});
    white{p}   = double(white{p});
    allRois{p} = double(allRois{p});
    
    if ~isnumeric(grey{p}),    error(['grey{'    num2str(p) '} was not numeric']); end
    if ~isnumeric(basal{p}),   error(['basal{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(white{p}),   error(['white{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(allRois{p}), error(['allRois{' num2str(p) '} was not numeric']); end

    grey{p}    = grey{p}    .* slicesCellArray([slice1(p), slice2(p)], size(allRois{p}));
    basal{p}   = basal{p}   .* slicesCellArray([slice1(p), slice2(p)], size(allRois{p}));
    white{p}   = white{p}   .* slicesCellArray([slice1(p), slice2(p)], size(allRois{p}));
    allRois{p} = allRois{p} .* slicesCellArray([slice1(p), slice2(p)], size(allRois{p}));
    
    switch (kindRoi)
        case 'grey'
            anRoi = grey{p};
        case 'basal'
            anRoi = basal{p};
        case 'white'
            anRoi = white{p};
        otherwise
            anRoi = allRois{p};
    end
    
    [cbfMlem{p}, cbfOsvd{p}, cbfSsvd{p}, FBayes{p}, ho1{p}, ho1gauss{p}] = ...
            peekCbfs(pidList(p), slice1(p), slice2(p), ...
            hoFileList(p), mlemTimes(p, 'cbf'), osvdTimes(p, 'cbf'), ssvdTimes(p, 'cbf'), anRoi, kindImg, 0);
    
    cbfMlem{p} = double(cbfMlem{p});
    cbfOsvd{p} = double(cbfOsvd{p});
    cbfSsvd{p} = double(cbfSsvd{p});
    FBayes{p}  = double(FBayes{p});
    ho1{p}     = double(ho1{p});
    
    if ~isnumeric(cbfMlem{p}),  error(['cbfMlem{'  num2str(p) '} was not numeric']); end
    if ~isnumeric(cbfOsvd{p}),  error(['cbfOsvd{'  num2str(p) '} was not numeric']); end
    if ~isnumeric(cbfSsvd{p}),  error(['cbfSsvd{'  num2str(p) '} was not numeric']); end
    if ~isnumeric(FBayes{p}),   error(['FBayes{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(ho1{p}),      error(['ho1{'      num2str(p) '} was not numeric']); end
end

switch (kindRoi)
    case 'grey'
        theRois = grey;
    case 'basal'
        theRois = basal;
    case 'white'
        theRois = white;
    case 'allrois'
        theRois = allRois;
    otherwise
        error('peekCoords does not yet implement multiple kinds of ROIs');
end

switch (kindImg)
    case 'F'
        theImgs = FBayes;
    case 'cbfSsvd'
        theImgs = cbfSsvd;
    case 'cbfOsvd' 
        theImgs = cbfOsvd;
    case 'cbfMlem'
        theImgs = cbfMlem;
    case 'ho1'
        theImgs = ho1;
    otherwise
        error('peekCoords.kindImg was unrecognizable');
end

theCoords = zeros(NPID,1);
for i = 1:NPID
    theCoords(i) = peekDoubleCoord(theRois{i}, theImgs{i});
end



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

    


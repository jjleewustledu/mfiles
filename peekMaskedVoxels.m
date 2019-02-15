%PEEKMASKEDVOXELS
%
% Usage:  theCoords = peekMaskedVoxels(kindRoi, kindImg, side, moment)
%
%         theCoords will be a vector of doubles, ordered ascending
%         kindRoi is 'grey', 'basal', 'white' or 'allrois'
%         kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd' or 'ho1' 
%         side    is 'ipsi', 'contra' -lateral to lesions, otherwise both sides
%________________________________________________________________

function theCoords = peekMaskedVoxels(kindRoi, kindImg, side, moment)

NPID = 19;
if (strcmp('allrois', kindRoi)) 
    NROI = 3; 
else
    NROI = 1;
end
if (strcmp('ipsi', side) || strcmp('contra', side))
  NSIDE = 1;
else
  NSIDE = 2;
end
    
    

% gather ROIs, image data, and truncate ROIs by available slices

theCoords = -1 .* ones(NPID*NROI*NSIDE,1);

for p = 1:NPID
    
    if (pidToExclude(p)) 
        for r = 1:NROI
            for s = 1:NSIDE
                idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;
                theCoords(idx) = -1.0;
            end
        end
        continue; 
    end
    
    [grey, basal, white, allRois] = peekRois(p, kindRoi, 'dip', 0, excludeCsfRoi(kindImg));

    grey    = double(grey);
    basal   = double(basal);
    white   = double(white);
    allRois = double(allRois);

    if ~isnumeric(grey),    error(['grey{'    num2str(p) '} was not numeric']); end
    if ~isnumeric(basal),   error(['basal{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(white),   error(['white{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(allRois), error(['allRois{' num2str(p) '} was not numeric']); end

    grey    = grey    .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
    basal   = basal   .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
    white   = white   .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
    allRois = allRois .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allRois));
    %%% dip_image(allRois)
    
    [cbfMlem, cbfOsvd, cbfSsvd, FBayes, ho1] = ...
            peekCbfs(pidList(p), slice1(p), slice2(p), ...
                     hoFileList(p), mlemTimes(p, 'cbf'), osvdTimes(p, 'cbf'), ssvdTimes(p, 'cbf'), allRois, kindImg, 0);

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

    for r = 1:NROI 
        for s = 1:NSIDE
        
            idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;

            if (strcmp('allrois', kindRoi))
                switch (r)
                    case 1
                        anRoi = grey;
                    case 2
                        anRoi = basal;
                    case 3
                        anRoi = white;
                    otherwise
                        error(['peekCoords.r -> ' num2str(r) ' was not recognizable']);                                   
                end
            else
                switch (kindRoi)
                    case 'grey'
                        anRoi = grey;
                    case 'basal'
                        anRoi = basal;
                    case 'white'
                        anRoi = white;
                    otherwise
                        error(['peekCoords.kindRoi -> ' kindRoi ' was not recognizable']);                                   
                end
            end
            %%% anRoi
            
            sideRoi = ones(size(anRoi));
            if (NSIDE == 1)
              switch (side)
               case 'ipsi'
                sideRoi = roiIpsiLesion(p);
               case 'contra'
                sideRoi = roiContraLesion(p);
              end
            else
                switch (s)
                    case 1
                        sideRoi = roiContraLesion(p);
                    case 2
                        sideRoi = roiIpsiLesion(p);
                    otherwise
                end                        
            end
            
            anRoi = anRoi .* sideRoi;

            theCoords(idx) = peekDoubleCoord(anRoi, theImg, moment);
            if strcmp('ho1', kindImg) theCoords(idx) = ...
                  counts_to_petCbf(theCoords(idx), p); end
        end
    end
end




%SLICESCELLARRAY
%
% Usage:  maskSlices = getSliceMask(sliceList, mskSizes)
%
%         maskSlices is a 3D Matlab array of doubles
%         sliceList is a row vector containing slice indices (ints)
%         mskSizes is a row vector containing the dims of the target mask
%
%________________________________________________________________

function sliceMask = getSliceMask(sliceList, mskSizes)

if size(sliceList, 1) > 1, 
    error('peekCoords.getSliceMask requires that sliceList be a row vector'); 
end
if size(mskSizes, 2) < 3,
    error('peekCoords.getSliceMask requires mskSizes to be at least 3D');
end

NSLICES   = size(sliceList, 2);
sliceMask = zeros(mskSizes(1,1), mskSizes(1,2), mskSizes(1,3));
oneSlice  = ones (mskSizes(1,1), mskSizes(1,2));
for s = 1:mskSizes(1,3)
    for s1 = 1:NSLICES
        if (s == sliceList(1,s1)) 
            sliceMask(:,:,s) = oneSlice; 
        end
    end
end

    


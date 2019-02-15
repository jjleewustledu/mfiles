%ROI_METRIC
%
% Usage:  metrics = roi_metrics(cbv, cbf, mtt, ccbv, k2, roiMask)
%
%         cbv, cbf, mtt, ccbv, k2 -> double dipimage montage object with perfusion images
%                         roiMask -> uint8 dipimage mask of roi pixels
%                         metrics -> [CbvList...
%                                     CbfList...
%                                     MttList...
%                                     CcbvList...
%                                     K2List]
%         
% Also See:  DIPLib
%
% J. J. Lee, 2004

function metrics = roi_metrics(cbv, cbf, mtt, ccbv, k2, roiMask)

TRIM_PERCENT = 2;
SHOW_STATS = true;

% squeeze all arrays, which in DIPLib 
% often have a trailing singleton dimension
cbv = squeeze(cbv);
cbf = squeeze(cbf);
mtt = squeeze(mtt);
ccbv = squeeze(ccbv);
k2 = squeeze(k2);
roiMask = squeeze(roiMask);

% internal matlab-native arrays
sizes = size(cbv);
height = sizes(2);
width  = sizes(1);
Nroi = sum(roiMask);
CbvList  = zeros(Nroi, 1);
CbfList  = zeros(Nroi, 1);
MttList  = zeros(Nroi, 1);
CcbvList = zeros(Nroi, 1);
K2List   = zeros(Nroi, 1);

% scanner
Iroi = 1;
for y = 0:height-1
    if (mod(y,100) == 0)
        disp(['scanning image row ' num2str(y) '...']);
    end
    for x = 0:width-1
        if roiMask(x,y)
            CbvList(Iroi,1 ) = double(cbv(x,y));
            CbfList(Iroi,1)  = double(cbf(x,y));
            MttList(Iroi,1)  = double(mtt(x,y));
            CcbvList(Iroi,1) = double(ccbv(x,y));
            K2List(Iroi,1)   = double(k2(x,y));
            Iroi = Iroi + 1;
        end
    end
end

if SHOW_STATS
    Cbv_mean = trimmean(CbvList, TRIM_PERCENT);
    Cbv_std  = std(CbvList);
    disp(['CBV:   mean = ' num2str(Cbv_mean) ' std = ' num2str(Cbv_std)]);
    
    Cbf_mean = trimmean(CbfList, TRIM_PERCENT);
    Cbf_std  = std(CbfList);
    disp(['CBF:   mean = ' num2str(Cbf_mean) ' std = ' num2str(Cbf_std)]);
    
    Mtt_mean = trimmean(MttList, TRIM_PERCENT);
    Mtt_std  = std(MttList);
    disp(['MTT:   mean = ' num2str(Mtt_mean) ' std = ' num2str(Mtt_std)]);
    
    Ccbv_mean = trimmean(CcbvList, TRIM_PERCENT);
    Ccbv_std  = std(CcbvList);
    disp(['cCBV:  mean = ' num2str(Ccbv_mean) ' std = ' num2str(Ccbv_std)]);
    
    K2_mean = trimmean(K2List, TRIM_PERCENT);
    K2_std  = std(K2List);
    disp(['K2:    mean = ' num2str(K2_mean) ' std = ' num2str(K2_std)]);
end

metrics = [CbvList'; CbfList'; MttList'; CcbvList'; K2List'];


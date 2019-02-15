%roiTruncateSlices
%
% roiTruncateSlices(roiFilename, minSlice, maxSlice)
%
%                   roiFilename - fully qualified filename string
%                   minSlice    - min slice (dip_image index) to keep
%                   maxSlice    - max slice ("              ) to keep

function roi = roiTruncateSlices(roiFilename, minSlice, maxSlice)
  
  perfmask = newim(256, 256, 32, 1);
  onesSlice = dip_image(ones(256, 256));
  for i = minSlice:maxSlice
    perfmask(:,:,i,0) = onesSlice;
  end
  
  roi = read4d(roiFilename, 'native', 'uint8', 256, 256, 32, 1, 0, 0, 0);
  roi = roi*perfmask;
  write4d(roi, 'uint8', 'native', roiFilename);
  
  
  
  
  
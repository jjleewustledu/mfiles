%PARENCHYMAMASK uses Josh Shimony's algorithm for isolating brain
%               parenchyma from extracranial reconstruction artifacts 
%
%               empirically, cutoff = [70, 400] works for raw DSC values
%
% $Author$
% $Date$
% $Revision$
% $Source$

function mask = parenchymaMask(mont2D, cutoff)

  dims = size(mont2D);
  FILT_SIGMA = 3;
  
  % smoothing filter
  mask = newim(dims(1), dims(2), 'double');
  mask = gaussf(mont2D,FILT_SIGMA);

  cutoffIm = newim(dims(1), dims(2), 'double');
  cutoffIm = cutoff;
  
  mask = mask > cutoff;


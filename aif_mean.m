% AIF_MEAN returns a vector of timepoints comprising the mean of
%          all spatially distributed DSC-MR perfusion timepoints, 
%          averaged over all pixels from within brain parenchyma
%
% USAGE:   mean_timepoints = aif_mean(baseline_image, montage)
%
%          baseline_image -> averaged, baseline EPI image
%          montage        -> dipimage object
%
% $Author$
% $Date$
% $Version$
% $Source$

function mean_timepoints = aif_mean(baseline_image, montage)

  % parameters
  
  VERBOSE = 0;
  FRAC_THRESH = 0.1;
  threshold = FRAC_THRESH*max(montage);

  if VERBOSE
    disp(['\n>> entering FUNCTION aif_mean...\n']);
    disp(['   max    baseline  pixel -> ' num2str(max   (baseline_image))]);
    disp(['   mean   baseline  pixel -> ' num2str(mean  (baseline_image))]);
    disp(['   median baseline  pixel -> ' num2str(median(baseline_image))]);
    disp(['   min    baseline  pixel -> ' num2str(min   (baseline_image))]);
    disp(['   std    baseline  pixel -> ' num2str(std   (baseline_image))]);
  end

  mask = baseline_image > threshold; % business logic!
  mcount = sum(mask);
  if (mcount < 1) 
    error('   mcount tabulated to zero!'); end
  disp(['   mask has ' num2str(mcount) ' nonzero elements' ]);

  if VERBOSE
    disp(['   max    masked pixel -> ' num2str(max   (montage.image))]);
    disp(['   mean   masked pixel -> ' num2str(mean  (montage.image))]);
    disp(['   median masked pixel -> ' num2str(median(montage.image))]);
    disp(['   min    masked pixel -> ' num2str(min   (montage.image))]);
    disp(['   std    masked pixel -> ' num2str(std   (montage.image))]);
  end 
  
  magic = nil_magic;
  for t = 1:magic.Timestep:magic.NumTimes
    maskedMont = montage(:,:,t-1)*mask;
    mean_timepoints(t) = sum(maskedMont)/mcount;
  end

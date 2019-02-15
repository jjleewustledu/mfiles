% AIF_BASELINE returns a baseline montage image in 2D, 
%              averaged between timepoints time0 and timef
%
% USAGE:  baseline = aif_baseline(montage3d)
% 
%         montage3d -> 3D dipimage object ordered [x-pixel, y-pixel, times]
%         time0 -> initial time-point to sample
%         timef -> final time-point to sample
%
% $Author$
% $Date$
% $Version$
% $Source$

function baseline = aif_baseline(montage3d)
  
  %%disp('\n>> entering FUNCTION aif_baseline\n');  

  magic = nil_magic;
  time0 = magic.blTime0;
  timef = magic.blTimeF;
  
  baseline = newim(magic.Dim*magic.RowsMont, magic.Dim2*magic.ColsMont);
  baseline = montage3d(:,:,time0); % 1st time point

  if (timef > time0)
    for t = time0+1:timef
      baseline = baseline + montage3d(:,:,t); % subsequent time points
    end
    baseline = baseline/(timef - time0 + 1); % Delta time >= 2
  else
    error('timef <= time0');
  end

% PROCESS_MEAN_AIF
%
% USAGE:  processMeanAif(rawfile, aifpath, side, slice, clicks)
%
% SEE ALSO:
%
% PARAMETERS:
%
% $Author$
% $Date$
% $Revision$
% $Source$

function processMeanAif(rawfile, aifpath, side, slice, clicks)

  TIMES_TO_SKIP   = 12;
  TIMES_TO_SAMPLE = 20;
  LENX            = 256;
  LENY            = 256;
  LENZ            = 8;
  LENT            = TIMES_TO_SKIP + TIMES_TO_SAMPLE;
  ONES            = dip_image(ones(1, TIMES_TO_SKIP));
  SCR_SZ          = get(0,'ScreenSize');
  WIN_EDG         = 4;
  WIN_WID         = 256 + 2*WIN_EDG;
  WIN_HGT         = 305;
  
  truncRaw = read4d(rawfile,'ieee-be','single',LENY,LENX,LENZ,TIMES_TO_SAMPLE,0,0,TIMES_TO_SKIP);
  sumTruncRaw = squeeze(sum(truncRaw, [], [1 2 3]));
  dipfig('truncRaw', [WIN_EDG+2*WIN_WID WIN_EDG+WIN_HGT 512 512]) % [(SCR_SZ(3)/2) (SCR_SZ(4)/2-300) 512 512])
  dipshow(truncRaw)
  
  aifs = newim(LENT, size(clicks,1));   
  for i = 1:size(clicks,1)
      aifs(0:TIMES_TO_SKIP-1, i-1) = ONES*truncRaw(clicks(i,1), clicks(i,2), slice, 0);
      % disp(['aifs ~ ' num2str(size(aifs(TIMES_TO_SKIP:LENT-1, i-1))) ' truncRaw ~ ' num2str(size(squeeze(truncRaw(clicks(i,1), clicks(i,2), slice, :))))])
      aifs(TIMES_TO_SKIP:LENT-1, i-1) = squeeze(truncRaw(clicks(i,1), clicks(i,2), slice, :));
  end
  %figure('Name', 'aifs','Position',[1 SCR_SZ(4)/2 SCR_SZ(3)/2 SCR_SZ(4)/2])
  dipfig('aifs', [WIN_EDG+WIN_WID WIN_EDG+2*WIN_HGT 256 256]) % [300 (SCR_SZ(4)/2-300) 256 256])
  dipshow(aifs)
  
  meanAif = sum(aifs,[],2);
  meanAif = dip_image(double(meanAif)/size(clicks,1));
  %figure('Name', 'meanAif','Position',[1 SCR_SZ(4)/2 SCR_SZ(3)/2 SCR_SZ(4)/2])
  dipfig('meanAif', [WIN_EDG WIN_EDG+2*WIN_HGT 256 256]) % [1 (SCR_SZ(4)/2+300) 256 256])
  dipshow(meanAif)
  
  meanRaw = newim(LENT);
  for t = 0:TIMES_TO_SKIP
      meanRaw(t) = squeeze(sumTruncRaw(0));
  end
  meanRaw(TIMES_TO_SKIP:LENT-1) = sumTruncRaw(0:TIMES_TO_SAMPLE-1);
  meanRaw = dip_image(double(meanRaw)/LENX*LENY*LENZ);
  %figure('Name', 'meanRaw','Position',[1 SCR_SZ(4)/2 SCR_SZ(3)/2 SCR_SZ(4)/2])
  dipfig('meanRaw', [WIN_EDG WIN_EDG+WIN_HGT 256 256]) % [1 (SCR_SZ(4)/2-300) 256 256])
  dipshow(meanRaw)
  
  logfile = [aifpath '\\' side '.log'];
  logid = fopen(logfile, 'wt', 'native');
  fprintf(logid, ['raw data read from ... ' rawfile]);
  fprintf(logid, 'skipping %i timepoints; then sampling %i timepoints\n', TIMES_TO_SKIP, TIMES_TO_SAMPLE);
  fprintf(logid, 'slice = %i; clicks = \n', slice);
  fprintf(logid, '%12.4f %12.4f\n', clicks);
  fprintf(logid, '\n');
  fprintf(logid, 'mean of %i clicked AIFs =\n', size(clicks,1));
  fprintf(logid, '%12.4f\n', double(squeeze(meanAif))');
  fprintf(logid, '\n');
  fprintf(logid, 'mean over %i * %i * %i raw voxels =\n', LENX, LENY, LENZ);
  fprintf(logid, '%22.4f\n', double(squeeze(meanRaw))');
  fprintf(logid, '\n');
  fclose(logid);
  disp(['successfully wrote aif processing log for side ' side ' to file ' logfile]);
  
  write4d(aifs,   'single','ieee-be',[aifpath '\aifs_'    side '.4dfp.img'])
  write4d(meanAif,'single','ieee-be',[aifpath '\meanAif_' side '.4dfp.img'])

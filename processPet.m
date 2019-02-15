%PROCESSPET reads PET perfusion data in raw format and produces intermediate 
%           processing files useful for Matlab and internal NIL software
%
% $Author: jjlee $
% $Date: 2003/12/02 11:09:31 $
% $Revision: 1.1 $
% $Source: /cygdrive/c/data/home/dip_local/RCS/processRaw.m,v $
%
% USAGE:  processPet(ptnum)
%         e.g., procesPet(3)

function processPet(PTnum)
  
  MASK_DIR = 'T:\masks\';
  PET_DIR  = 'U:\wernicke\backups\pet\';
  RESULTS_DIR = 'T:\pet\';
  DIFF_THRESH   = 1.0;           % choose [0.0, 1.0]
  VAR_THRESH    = DIFF_THRESH^2; % choose [0.0, 1.0]
  FILTER_CBF    = 0;
  FILTER_HOM    = 0;
  FILTER_PIXELS = 6;
  WM_SCALING    = 0;
  DISPLAY       = 1;
  ARTMASK       = 0;
  EYEMASK       = 1;
  SEPARATE_MASKS = 1;
  ptStr  = ['pt'  num2str(PTnum)];
  cbfmaskFilename = [MASK_DIR ptStr '\cbfmask.dat'];
  homFilename = [PET_DIR ptStr '\rp_' ptStr '_cbf_g5.img'];
  homOutFilename = [RESULTS_DIR ptStr '\rp_' ptStr '_cbf_g5.dat']
  comFilename = [PET_DIR ptStr '\rp_' ptStr '_cbv_g5.img'];
  comOutFilename = [RESULTS_DIR ptStr '\rp_' ptStr '_cbv_g5.dat']
  mtmOutFilename = [RESULTS_DIR ptStr '\rp_' ptStr '_mtt_g5.dat']

  % preliminary masks
  % =================

  if ARTMASK
    try
      artmask = readcollection([MASK_DIR ptStr '\artmask.dat'], ...
			       'uint8', 512, 1024, 1);  
      if DISPLAY 
          dipfig(196, 'artmask')
          artmask
      end
    catch
      error('could not read artmask');
    end
  else
    artmask = 1;
  end
  
  eyemask = newim(512, 1024, 1); % not sure if ~eyemask would work if
				 % it were not a dipimage object
  eyemask = 0;
  if EYEMASK
    try
      disp(['   trying to read ' MASK_DIR ptStr '\eyemask.dat']);
      eyemask = readcollection([MASK_DIR ptStr '\eyemask.dat'], ...
			       'uint8', 512, 1024, 1);  
      if DISPLAY 
          dipfig(197, 'eyemask')
          eyemask
      end
    end
  end  

  cbfmask  = readcollection(cbfmaskFilename, 'uint8', 512, 1024, 1);

  % get hom
  % =======

  try
    if strcmp(ptStr, 'pt7') | strcmp(ptStr, 'pt4')
      disp('calling nilio_petread2');
      hom = nilio_petread2(8, homFilename); 
    else 
      hom = nilio_petread (8, homFilename); 
    end
    if FILTER_HOM
      hom = gaussf(hom, FILTER_PIXELS); 
    end
    if ~SEPARATE_MASKS
        hom = hom*cbfmask*artmask*(~eyemask);
    end
  catch
    error('could not read hom');
  end
  
  if FILTER_HOM
    hom = gaussf(hom, FILTER_PIXELS); 
  end

  % get com
  % =======

  try
    if strcmp(ptStr, 'pt4') | strcmp(ptStr, 'pt7') 
      com = nilio_petread2(8, comFilename); 
    else
      com = nilio_petread (8, comFilename); 
    end
    if FILTER_HOM
      com = gaussf(com, FILTER_PIXELS); 
    end
    if ~SEPARATE_MASKS
        com = com*cbfmask*artmask*(~eyemask);
    end
  catch
    error('could not read com');
  end
  
  if FILTER_HOM
    hom = gaussf(hom, FILTER_PIXELS); 
    com = gaussf(com, FILTER_PIXELS); 
  end

  % compute mtm
  % ===========

  homUnderflowMask = hom < 0.001;
  ones = newim(hom);
  ones = 1;
  homCorr = ~homUnderflowMask*hom + homUnderflowMask*ones;
  mtm = com/homCorr;
  
  % show & write
  % ============

  if DISPLAY
    dipfig(201, 'hom') 
    hom
    dipfig(202, 'com') 
    com
    dipfig(203, 'mtm') 
    mtm
    if SEPARATE_MASKS
        dipfig(204, 'cbfmask')
        cbfmask*artmask*(~eyemask)
    end
  end
  
  writecollection(hom, 'double', homOutFilename);
  writecollection(com, 'double', comOutFilename);
  writecollection(mtm, 'double', mtmOutFilename);



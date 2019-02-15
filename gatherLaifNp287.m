%
%  USAGE:  imgs = gatherLaifNp287(pid)
%
%          pid:		patient ID
%
%          imgs:	cell-array of dip_image
%
%  Created by John Lee on 2008-04-26.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function imgs = gatherLaifNp287(pid)

	METRICS = { 'F' 'CBV' 'Mtt' 'Delta' 'FracC' 'FracRec' 'FractDrop' 'S0' 'S1' 'S2' 'T0' 'T02' 'Alpha' 'Beta' ...
	            'ProbModel' 'ProbSignal' 'NoiseSd' };
            
    PDFMETRICS = { 'mean' 'peak' 'var' };

	PIDS = { 'vc1535' 'vc1563' 'vc4103' 'vc4153' 'vc4336' ...
             'vc4354' 'vc4405' 'vc4420' 'vc4426' 'vc4437' ...
             'vc4497' 'vc4500' 'vc4520' 'vc4634' 'vc4903' ...
             'vc5591' 'vc5625' 'vc5647' 'vc5821' }; % vc4354 is same patient as vc4103

	SIZES = [256 256 8 1];
	
	PATH = ['/mnt/hgfs/perfusion/vc/' pid '/Bayes/'];
	
	[pid p] = ensurePid(pid);
	
    imgs = cell(size(METRICS,2),size(PDFMETRICS,2));
	for i = 1:size(METRICS,2)
        for j = 1:size(PDFMETRICS,2)
            imgs{i,j} = newim(SIZES); % pre-allocation of cell-arrays
        end
	end
	
	ifh.numberFormat        = 'float';
	ifh.orientation         = 2; % transverse
	ifh.scalingFactors      = [0.9375 0.9375 6.0];
	ifh.sliceThickness      = 6.0;
	ifh.lengths             = SIZES;
	ifh.originatingSystem   = 'Siemens Magnetom Vision 1.5T';
	ifh.parameterFilename   = '/usr/appl/proto/016/c/head/Colin_experiments/perfusion_venous.pr';
	ifh.sequenceFilename    = '/usr/appl/sequence/ep2d_fid_54b1250_11.ekc';
	ifh.sequenceDescription = 'ep_fid';
    ifh.conversionProgram   = 'LAIF MCMC-SA, Matlab R2007b, Diplib 1.6';
		
	for m = 1:size(METRICS,2)
        for n = 1:size(PDFMETRICS,2)
            ifh.imageModality  = ['DSC MR Perfusion, LAIF, ' METRICS{m} ', ' PDFMETRICS{n}];
            ifh.nameOfDataFile = [METRICS{m} '_' PDFMETRICS{n} '_xr3d.4dfp.img'];
            ifh.patientID      = pid;
            nilio_writeIfh(ifh, [PATH METRICS{m} '_' PDFMETRICS{n} '_xr3d.4dfp.ifh']);
            try
                imgs{m,n} = peekLaifNp287(pid, METRICS{m}, PDFMETRICS{n});
                write4d(imgs{m,n}, 'float', 'ieee-be', [PATH METRICS{m} '_' PDFMETRICS{n} '_xr3d.4dfp.img']);	
            catch ME
                warning(ME);
            end
        end
	end

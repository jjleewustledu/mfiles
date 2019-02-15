%
%  USAGE:  fname = filenameLaif(pid, metric, sliceIdx, centralTend, fileFrmt)
%
%          pid:			patiend ID
%          metric:		PET perfusion metric (default = 'F')
%          sliceIdx:	slice index (default = 1)
%          centralTend:	measure of central tendency:  'mean', 'peak', 'var' (default = 'mean')
%          fileFrmt:    format specifier:  'ascii', 'fdf', '4dfp' (default = '4dfp')
%
%          fname:		filename returned as string
%
%  Created by John Lee on 2008-04-02.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function fname = filenameLaif(pid, metric, sliceIdx, centralTend, fileFrmt)

	FQ_FILENAME = true;
    	
    switch (nargin)
		case 1
			metric = 'F';
			sliceIdx = '0001';
			centralTend = 'mean';
			fileFrmt = '4dfp';
		case 2
			sliceIdx = '0001';
			centralTend = 'mean';
			fileFrmt = '4dfp';
		case 3
			sliceIdx = sliceIdx2str(sliceIdx);
			centralTend = 'mean';
			fileFrmt = '4dfp';
		case 4
			sliceIdx = sliceIdx2str(sliceIdx);
			fileFrmt = '4dfp';
		case 5
			sliceIdx = sliceIdx2str(sliceIdx);
		otherwise
			error(help('filenameLaif'));
	end

    [pid, p] = ensurePid(pid);
    metric = lower(metric);
        
    switch(metric)
        case 'f'
            mstem = 'F';
        case 'cbv'
            switch (fileFrmt)
                 case 'ascii'
                     mstem = 'CBV_Int';
                 case {'fdf', '4dfp'}
                     mstem = 'CBV';
                 otherwise
                     mstem = 'CBV';
            end
        case 'mtt'
            mstem = 'Mtt';
        case 'delta'
            mstem = 'Delta';
        case 'alpha'
            mstem = 'Alpha';
        case 'beta'
            mstem = 'Beta';
        case 's0'
            mstem = 'S0';
        case 's1'
            mstem = 'S1';
        case 's2'
            mstem = 'S2';
        case 't0'
            mstem = 'T0';
        case 't1'
            mstem = 'T0';
        case 't2'
            mstem = 'T02';
        case 'fracc'
            mstem = 'FracC';
        case 'fracrec'
            mstem = 'FracRec';
        case 'fracdrop'
            mstem = 'FracDrop';
        case 'noisesd'
            mstem = 'NoiseSd';
        case 'probmodel'
            mstem = 'ProbModel';
        case 'probsignal'
            mstem = 'ProbSignal'
        otherwise
            error(['filenameLaif:  could not recognize metric -> ' metric]);
    end

    centralTend  = lower(centralTend);
    fileFrmt     = lower(fileFrmt);
    folderSlice1 = ['2005oct27_slice' num2str(slice1(p)) '/'];
    folderSlice2 = ['2006aug29_slice' num2str(slice2(p)) '/'];
    
	switch (fileFrmt)
         case 'ascii'
             fname = [mstem '.0001.' centralTend '.Ascii'];
             if (FQ_FILENAME)
                 fname = [db('basepath') pid2np(pid) '/' pid '/Bayes/' folderSlice1 fname];
             end
         case 'fdf'
             if (strcmp('np287', pid2np(pid)))
                 fname = [mstem '.0001.' centralTend '.fdf'];
                 if (FQ_FILENAME)
                     fname = [db('basepath') pid2np(pid) '/' pid '/Bayes/' folderSlice2 fname];  
                 end
             else
                 fname = [mstem '.' sliceIdx '.' centralTend '.fdf'];
                 if (FQ_FILENAME)
                     fname = [db('basepath') pid2np(pid) '/' pid '/Bayes/' fname];                  
                 end
             end
             
         case '4dfp' 
             fname = [mstem '_' centralTend '_xr3d.4dfp.img'];
             if (FQ_FILENAME)
                 fname = [db('basepath') pid2np(pid) '/' pid '/Bayes/' fname]; end
         otherwise
             error(['filenameLaif:  could not recognize fileFrmt -> ' fileFrmt]);
    end  
    



    function str = sliceIdx2str(idx) 
    
        if (isa(idx, 'double'))
			if (idx < 10)
				str = ['000' num2str(idx)];
            elseif (idx < 100)
				str = ['00'  num2str(idx)];
			else
				error(['' ...
				'.sliceIdx2str:  does not support idx -> ' num2str(idx)])
			end
        elseif (isa(idx, 'char'))
			str = idx;
        else
            error(['filenameLaif.sliceIdx2str:  could not recognize idx -> ' idx]);    
		end

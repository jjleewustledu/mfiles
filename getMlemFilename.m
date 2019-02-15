%
%  USAGE:  filename = getMlemFilename(pid, metric)
%
%          pid: 	 string of form 'vc4354' or the corresponding int index
%          			 from pidList
%          metric:   string for metric:  'cbf', 'cbv', 'mtt'
%          filename: ending in '.4dfp', which is useful for NIfTI
%
%  Created by John Lee on 2009-01-04.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function fname = getMlemFilename(pnum, metric)

	switch (nargin)
		case 2
		otherwise
			error(help('getMlem'));
    end
	imaging  = mlfsl.ImagingComponent(pnum);
    
    CBF_STEM = 'SHIMONY_CBF_MLEM_LOGFRACTAL_VONKEN_LOWPASS';
    CBV_STEM = 'SHIMONY_CBV_MLEM_LOGFRACTAL_VONKEN_LOWPASS';
    MTT_STEM = 'SHIMONY_MTT_MLEM_LOGFRACTAL_VONKEN_LOWPASS';
	SUFFIX   = '.4dfp';
	QUIET    = 0;
    fname    = '';
	
	switch (lower(metric))
		case 'cbf' 
            try    
                fname = [imaging.pnumPath '4dfp/' CBF_STEM mlemVersion(pnum) mlemDate(pnum) SUFFIX];
                disp(['getMlem:  found ' fname]);
            catch Ecbf
                if ~QUIET,
                    warning(['getMlem:  could not find ' fname]); disp(Ecbf); end
            end
        case 'cbv' 
            try    
                fname = [imaging.pnumPath '4dfp/' CBV_STEM mlemVersion(pnum) mlemDate(pnum) SUFFIX];
                disp(['getMlem:  found ' fname]);
            catch Ecbv
                if ~QUIET,
                    warning(['getMlem:  could not find ' fname]); disp(Ecbv); end
            end
        case 'mtt' 
            try    
                fname = [imaging.pnumPath '4dfp/' MTT_STEM mlemVersion(pnum) mlemDate(pnum) SUFFIX];
                disp(['getMlem:  found ' fname]);
            catch Emtt
                if ~QUIET,
                    warning(['getMlem:  could not find ' fname]); disp(Emtt); end
            end
		otherwise
			error(['getMlemFilename:  could not recognize metric ' metric]);
	end

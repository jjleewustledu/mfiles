%
%  USAGE:  fstem = filestemMlem(pid, metric)
%
%          pid:		patiend ID
%          metric:	PET perfusion metric
%
%          fstem:	filestem returned as string
%
%  Created by John Lee on 2008-04-02.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function fstem = filestemMlem(pid, metric)

    VOL_MODEL   = 'SHIMONY';
    ALG         = 'MLEM';
    CONC_MODEL  = 'LOGFRACTAL';
    HCT         = 'VONKEN';
    FILT        = 'LOWPASS';
    VERSION     = '00-1-1';

    switch (nargin)
		case 2
			[pid p] = ensurePid(pid);
		otherwise
			error(help('filestemMlem'));
	end
    
    [pid, p] = ensurePid(pid);
    
    switch(lower(metric))
        case 'cbf'
            fstem = [VOL_MODEL '_CBF_' ALG '_' CONC_MODEL '_' HCT '_' FILT '_' VERSION '_' runDate(p)];
        case 'cbv'
            fstem = [VOL_MODEL '_CBV_' ALG '_' CONC_MODEL '_' HCT '_' FILT '_' VERSION '_' runDate(p)];
        case 'mtt'
            fstem = [VOL_MODEL '_MTT_' ALG '_' CONC_MODEL '_' HCT '_' FILT '_' VERSION '_' runDate(p)];
        otherwise
            error('filestemLaif supports only cbf at present');
    end
    
	function dateStr = runDate(p)
	    dates = {   '2008-1-10' ...
	                '2008-3-6' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-10' ...
	                '2008-3-10' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-3-9' ...
	                '2008-2-3' };
	    dateStr = dates{p};
    

%
%  USAGE:  fname = filenameMlem(pid, metric)
%
%          pid:			patiend ID
%          metric:		PET perfusion metric (default = 'F')
%
%          fname:		filename returned as string
%
%  Created by John Lee on 2008-04-02.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function fname = filenameMlem(pid, metric)

	FQ_FILENAME = true;
    	
    switch (nargin)
		case 1
			metric = 'CBF';
		case 2
		otherwise
			error(help('filenameMlem'));
	end

    [pid, p] = ensurePid(pid);
    metric   = upper(metric);
    fname    = [filestemMlem(pid, metric) '.4dfp.img'];
    if (FQ_FILENAME)
        fname = [db('basepath') pid2np(pid) '/' pid '/MLEM/' fname]; end
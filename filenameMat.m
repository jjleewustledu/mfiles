%
%  USAGE:  fname = filenameMat(pid)
%
%          pid:			patiend ID
%          fname:		filename returned as string
%
%  Created by John Lee on 2008-04-02.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function fname = filenameMat(pid)

	FQ_FILENAME = true;
    MAT_FILENAMES = { ...
            '<unknown>' 'P002GE_M.mat' 'P003GE_MSS-1.mat' 'P004GE_A_SVD.mat' 'P005GE_M.mat' ...
            'P006GE_A.mat' 'P007GE_A.mat' 'P008GE_A.mat' 'P009GE_M.mat' 'P010GE_A.mat' ...
            'P011GE_A_NoFS.mat' '<unknown>' 'P012GE_A_NoFS.mat' 'P013GE_A_FS.mat' };
    	
    switch (nargin)
		case 1
		otherwise
			error(help('filenameMat'));
	end

    [pid, p] = ensurePid(pid, 'np797');
    fname    = MAT_FILENAMES{p-18};
    dbase    = mlfsl.Np797Registry.instance;
    if (FQ_FILENAME)
        fname = [dbase.patient_path 'qCBV/' fname]; end

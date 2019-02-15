%
%  USAGE:  filename = getLaifFilenameFilename(pid, metric)
%
%          pid: 	string of form 'vc4354' or the corresponding int index
%          			from pidList
%          metric:	string for metric:  'cbf', 'cbv', 'mtt'
%          filename: string ending in '.4dfp' for NIfTI
%          
%
%  Created by John Lee on 2009-01-04.
%  Copyright (c) 2009 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function fname = getLaifFilename(pid, metric)
	
    switch (nargin)
		case 2
			[pid p] = ensurePid(pid);
		otherwise
			error(help('getLaifFilename'));
    end

    XR3D_STEM = '_mean_xr3d.4dfp';   
    fname     = '';
    try
        fname = [pathLaif(pid) metric XR3D_STEM];
        disp(['getLaifFilename:  found ' fname]);
    catch Efname
        warning('getLaifFilename:metric:fname', ['could not find ' fname]);
        disp(Efname);
    end
	
end
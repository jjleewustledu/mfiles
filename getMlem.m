%
%  USAGE:  img = getMlem(pid, metric)
%
%          pid: 	string of form 'vc4354' or the corresponding int index
%          			from pidList
%          metric:	string for metric:  'cbf', 'cbv', 'mtt'
%          img:		dip_image object
%
%  Created by John Lee on 2008-04-01.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function img = getMlem(pid, metric)

    warning('FunctionUsage:Deprecated', 'getMlem is deprecated');
	
    QUIET  = 0;
	sizes  = peek4dfpSizes();
	img    = newim(sizes);
    metric = lower(metric);
	fname  = [getMlemFilename(pid, metric) '.img'];
    
	switch (metric)
		case 'cbf' 
            try
                img = read4d(fname,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0);
                disp(['getMlem:  found ' fname]);
            catch Ecbf
                if ~QUIET,
                    warning(['getMlem:  could not find ' fname]); disp(Ecbf); end
            end
        case 'cbv' 
            try 
                img = read4d(fname,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0);
                disp(['getMlem:  found ' fname]);
            catch Ecbv
                if ~QUIET,
                    warning(['getMlem:  could not find ' fname]); disp(Ecbv); end
            end
        case 'mtt' 
            try    
                img = read4d(fname,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0);
                disp(['getMlem:  found ' fname]);
            catch Emtt
                if ~QUIET,
                    warning(['getMlem:  could not find ' fname]); disp(Emtt); end
            end
		otherwise
			error(['getMlem:  could not recognize metric ' metric]);
	end

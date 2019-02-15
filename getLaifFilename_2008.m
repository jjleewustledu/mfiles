%
%  USAGE:  img = getLaif(pid, metric)
%
%          pid: 	string of form 'vc4354' or the corresponding int index
%          			from pidList
%          metric:	string for metric:  'cbf', 'cbv', 'mtt'
%
%          
%
%  Created by John Lee on 2008-04-01.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function img = getLaif(pid, metric)

    ASC_STEM     = '.0001.mean.Ascii';
    FOURDFP_STEM = '.0001.mean.4dfp.img';
	
	switch (nargin)
		case 2
			[pid p] = ensurePid(pid);
		otherwise
			error(help('getLaif'));
	end
	
	sizes = peek4dfpSizes();
	img   = newim(sizes);
	
	switch (lower(metric))
		case 'cbf' 
            prefix = 'F';
		    try    
				fname1 = [pathLaif(pid, slice1(pid)) prefix ASC_STEM];
		        img(:,:,slice1(pid),0)  = ...
					squeeze(read4d(fname1,'ascii','float',sizes(1),sizes(2),1,1,0,0,0));
		        disp(['getLaif:  found ' fname1 ' for slice ' num2str(slice1(pid))]);
		    catch
		        warning(['getLaif:  could not find ' fname1 ' for slice ' num2str(slice1(pid))]);
		    end
		    try
				fname2 = [pathLaif(pid, slice2(pid)) prefix FOURDFP_STEM];
		        img(:,:,slice2(pid),0) = flipx4d( ...
		        	squeeze(read4d(fname2,'ieee-be','float',sizes(1),sizes(2),1,1,0,0,0)));
		        disp(['getLaif:  found ' fname2 ' for slice ' num2str(slice2(pid)) ', but needed to flip the orientation of the x-dimension']);
		    catch
		        warning(['getLaif:  could not find ' fname2 ' for slice ' num2str(slice2(pid))]);
            end
        case 'cbv' 
            prefix = 'CBV';
		    try    
				fname1 = [pathLaif(pid, slice1(pid)) prefix '_Int' ASC_STEM];
		        img(:,:,slice1(pid),0)  = ...
					squeeze(read4d(fname1,'ascii','float',sizes(1),sizes(2),1,1,0,0,0));
		        disp(['getLaif:  found ' fname1 ' for slice ' num2str(slice1(pid))]);
		    catch
		        warning(['getLaif:  could not find ' fname1 ' for slice ' num2str(slice1(pid))]);
		    end
		    try
				fname2 = [pathLaif(pid, slice2(pid)) prefix FOURDFP_STEM];
		        img(:,:,slice2(pid),0) = flipx4d( ...
		        	squeeze(read4d(fname2,'ieee-be','float',sizes(1),sizes(2),1,1,0,0,0)));
		        disp(['getLaif:  found ' fname2 ' for slice ' num2str(slice2(pid)) ', but needed to flip the orientation of the x-dimension']);
		    catch
		        warning(['getLaif:  could not find ' fname2 ' for slice ' num2str(slice2(pid))]);
            end
        case 'mtt' 
            prefix = 'Mtt';
		    try    
				fname1 = [pathLaif(pid, slice1(pid)) prefix ASC_STEM];
		        img(:,:,slice1(pid),0)  = ...
					squeeze(read4d(fname1,'ascii','float',sizes(1),sizes(2),1,1,0,0,0));
		        disp(['getLaif:  found ' fname1 ' for slice ' num2str(slice1(pid))]);
		    catch
		        warning(['getLaif:  could not find ' fname1 ' for slice ' num2str(slice1(pid))]);
		    end
		    try
				fname2 = [pathLaif(pid, slice2(pid)) prefix FOURDFP_STEM];
		        img(:,:,slice2(pid),0) = flipx4d( ...
		        	squeeze(read4d(fname2,'ieee-be','float',sizes(1),sizes(2),1,1,0,0,0)));
		        disp(['getLaif:  found ' fname2 ' for slice ' num2str(slice2(pid)) ', but needed to flip the orientation of the x-dimension']);
		    catch
		        warning(['getLaif:  could not find ' fname2 ' for slice ' num2str(slice2(pid))]);
		    end
		otherwise
			error(['getLaif:  could not recognize perfusion metric ' metric]);
	end

%
%  USAGE:  laifImg = peekLaifNp287(pid, metric, pdfmetric)
%
%          pid:			patient ID 
%          metric:		'F', 'CBV', 'MTT', 'Delta', 'Alpha', Beta', ...
%                       (defaults to 'F')
%          pdfMetric:	'mean', 'peak', 'var' 
%                       (defaults to 'mean')
%
%          laifImg:		dip_image
%
%  Created by John Lee on 2008-04-26.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function laifImg = peekLaifNp287(pid, metric, pdfmetric)

	SIZES = [256 256 8 1];
	PDF_METRIC = 'mean';
	
	switch (nargin)
		case 1
			metric = 'F';
			pdfmetric = PDF_METRIC;
		case 2
			if strcmp('cbv', lower(metric))
			    metric_Int = 'CBV_Int';
			    metric_INT = 'CBV_INT';
			end
			pdfmetric = PDF_METRIC;
		case 3
			if strcmp('cbv', lower(metric))
			    metric_Int = 'CBV_Int';
			    metric_INT = 'CBV_INT';
			end
		otherwise
			error(help('peekLaifNp287'));
	end
	
	[pid p] = ensurePid(pid);
	path1  = ['/mnt/hgfs/perfusion/vc/' pid '/Bayes/2005oct27_slice' num2str(slice1(p)) '/'];
	path2  = ['/mnt/hgfs/perfusion/vc/' pid '/Bayes/2006aug29_slice' num2str(slice2(p)) '/'];
	
	laifImg = newim(SIZES);
	
	% TRY SLICE1
	
	if strcmp('cbv', lower(metric)), metric = metric_Int; end
	fname1 = [path1 metric '.0001.' pdfmetric '.Ascii'];
	try    
	    bayesSlice1 = read4d(fname1,'ascii','single',SIZES(1),SIZES(2),1,1,0,0,0);
		disp(['peekLaifNp287 found ' fname1 ' for slice1(' num2str(p) ')']);
		laifImg(:,:,slice1(p),0) = squeeze(bayesSlice1); 
	catch
	    warning(['peekLaifNp287 could not find ' fname1 ' for slice1(' num2str(p) ')']);
	end

	% TRY SLICE2
	
	if strcmp('cbv', lower(metric)), metric = metric_INT; end
	fname2 = [path2 metric '.0001.' pdfmetric '.4dfp.img'];
	try
	    bayesSlice2 = read4d(fname2,'ieee-be','single',SIZES(1),SIZES(2),1,1,0,0,0);
	    if (p == 6) 
			disp(['peekLaifNp287 found ' fname2 ' for slice2(' num2str(p) ')']);
		else
			bayesSlice2 = flipx4d(bayesSlice2); 
			disp(['peekLaifNp287 found ' fname2 ' for slice2(' num2str(p) '), but needed to flip the orientation of x']);
		end	    
		laifImg(:,:,slice2(p),0) = squeeze(bayesSlice2);
	catch
	    warning(['peekLaifNp287 could not find ' fname2 ' for slice2(' num2str(p) ')']);
	end
	
	
	

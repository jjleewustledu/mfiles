%
%  USAGE:  [pth sliceSet] = pathLaifSlice(pid, islice)
%
%          pid:		string of form 'vc4354' or the corresponding int index
%          			from pidList
%          islice:	dip_image slice index for Laif (optional)
%
%          pth:			string containing absolute unix path to fg ROIs
%          sliceSet:	sets defined for MCMC SA results from Larry Bretthorst
%
%  Created by John Lee on 2008-04-01.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function [pth sliceSet] = pathLaifSlice(pid, islice)

	switch (nargin)
		case 2
			[pid p] = ensurePid(pid);
		otherwise
			error(help('pathLaifSlice'));
	end
	
	sliceSet1 = [ 6 3  1  0 2 0 5 4 4 5 5 2 5 6 3 4 4 4 5 ];
	sliceSet2 = [ 3 2 -1 -1 1 1 4 3 3 4 4 1 4 5 2 3 3 3 4 ];
	
	switch (islice)
		case sliceSet1(p)
		 	pth = ['2005oct27_slice' num2str(sliceSet1(p)) '/'];
			sliceSet = 1;
		case sliceSet2(p)
			pth = ['2006aug29_slice' num2str(sliceSet2(p)) '/'];
			sliceSet = 2;
		otherwise
			pth = '';
			sliceSet = 0;
	end
		
		
	




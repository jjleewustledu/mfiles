%
%  USAGE:  [pth sliceSet] = pathLaif(pid, islice)
%
%          pid:		string of form 'vc4354' or the corresponding int index
%          			from pidList
%          islice:	dip_image slice index for Laif (optional)
%
%          pth:		string containing absolute unix path to fg ROIs
%          sliceSet:	sets defined for MCMC SA results from Larry Bretthorst
%
%  Created by John Lee.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function [pth sliceSet] = pathLaif(pid, islice)
	
    switch (nargin)
		case 1
			[pid p]           = ensurePid(pid);
			sliceFolder       = ''; 
            sliceSet          = [];
            READ_SLICE_FOLDER = 0;
		case 2
			[pid p]                = ensurePid(pid);
			[sliceFolder sliceSet] = pathLaifSlice(pid, islice);
            READ_SLICE_FOLDER      = 1;
		otherwise
			error(help('pathLaif'));
    end

    switch (pid2np(pid))
        case 'np287'
            pth = [peekDrive pid2np(pid) '/' pid '/Bayes/'];
            if (READ_SLICE_FOLDER)
                pth = [pth sliceFolder]; end
        case 'np797'
            pth = [peekDrive pid2np(pid) '/' pid '/4dfp/'];
        otherwise
            error(['pathLaif:  could not recognize pid2np(' pid ') -> ' pid2np(pid)]);
    end
    
end


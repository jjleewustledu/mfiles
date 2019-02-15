%
%  USAGE:  pth = pathMlem(pid)
%
%          pid: 		string of form 'vc4354' or the corresponding int index
%          				from pidList
%          pth:		path to MLEM data as string
%
%  Created by John Lee on 2008-04-02.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function pth = pathMlem(pid)

	switch (nargin)
		case 1
		[pid p] = ensurePid(pid);
		otherwise
			error(help('pathMlem'));
    end
    
	switch (pid2np(pid))
		case 'np287'
			pth = ['/Volumes/Parietal Data/cvl/np287/' pid '/MLEM/'];
		case 'np797'
			pth = [peekDrive '/np797/' pid '/4dfp/'];
		otherwise
			error(['pathMlem:  could not recognize pid2np(' pid ') -> ' pid2np(pid)]);
	end
    

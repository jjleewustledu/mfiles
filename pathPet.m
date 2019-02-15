%
%  USAGE:  pth = pathPet(pid)
%
%          arg1_in:	description
%          arg2_in:	description
%
%          arg1_out:	description
%          arg2_out:	description
%
%  Created by John Lee on 2008-04-02.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function pth = pathPet(pid)

	switch (nargin)
		case 1
			[pid p] = ensurePid(pid);
		otherwise
			error(help('pathPet'));
	end
	pth = [peekDrive '/' pid2np(pid) '/' pid '/962_4dfp/'];
	
    
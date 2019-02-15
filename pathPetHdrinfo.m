%
%  USAGE:  pth = pathPetHdrinfo(pid)
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
	pth = [peekDrive '/' pid2np(pid) '/' pid '/ECAT_EXACT/hdr_backup/'];
	
    
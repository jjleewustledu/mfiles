%
%  USAGE:  ver = mlemVersion(pid)
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

function ver = mlemVersion(pid)

	switch (nargin)
		case 1
		otherwise
			error(help('mlemVersion'));
	end
	
	ver = '_00-1-1';
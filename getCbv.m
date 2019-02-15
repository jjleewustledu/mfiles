%
%  USAGE:  cbv = getCbv(pid, modality)
%
%          pid: 		string of form 'vc4354' or the corresponding int index
%          				from pidList
%          modality:	string for modality:  'pet', 'laif', 'mlem'
%
%          cbv:			dip_image object
%
%  Created by John Lee on 2008-04-04.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function cbv = getCbv(pid, modality)

	switch (nargin)
		case 2
            [pid p] = ensurePid(pid);
		otherwise
			error(help('getCbv'));
	end
	
	switch (lower(modality)) 
		case 'pet'
			cbv = getPet(pid, 'cbv');
		case 'laif'
			cbv = getLaif(pid, 'cbv');
		case 'mlem'
			cbv = getMlem(pid, 'cbv');
		otherwise
			error(['getCbv:  could not recognize modality ' modality]);
	end

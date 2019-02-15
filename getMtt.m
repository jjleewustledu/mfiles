%
%  USAGE:  mtt = getMtt(pid, modality)
%
%          pid: 		string of form 'vc4354' or the corresponding int index
%          				from pidList
%          modality:	string for modality:  'pet', 'laif', 'mlem'
%
%          mtt:			dip_image object
%
%  Created by John Lee on 2008-04-04.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function mtt = getMtt(pid, modality)

	switch (nargin)
		case 2
            [pid p] = ensurePid(pid);
		otherwise
			error(help('getMtt'));
	end
	
	switch (lower(modality)) 
		case 'pet'
			mtt = getPet(pid, 'mtt');
		case 'laif'
			mtt = getLaif(pid, 'mtt');
		case 'mlem'
			mtt = getMlem(pid, 'mtt');
		otherwise
			error(['getMtt:  could not recognize modality ' modality]);
	end

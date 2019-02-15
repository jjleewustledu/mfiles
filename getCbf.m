%
%  USAGE:  cbf = getCbf(pid, modality)
%
%          pid: 		string of form 'vc4354' or the corresponding int index
%          				from pidList
%          modality:	string for modality:  'pet', 'laif', 'mlem'
%
%          cbf:			dip_image object
%
%  Created by John Lee on 2008-04-01.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function cbf = getCbf(pid, modality)

	switch (nargin)
		case 2
            [pid p] = ensurePid(pid);
		otherwise
			error(help('getCbf'));
	end
	
	switch (lower(modality))
		case 'pet'
			cbf = getPet(pid, 'cbf');
		case 'laif'
			cbf = getLaif(pid, 'cbf');
		case 'mlem'
			cbf = getMlem(pid, 'cbf');
		otherwise
			error(['getCbf:  could not recognize modality ' modality]);
    end

    

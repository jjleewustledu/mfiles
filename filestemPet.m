%
%  USAGE:  fstem = filestemPet(pid, metric)
%
%          pid:		patiend ID
%          metric:	PET perfusion metric
%
%          fstem:	filestem returned as string
%
%  Created by John Lee on 2008-04-02.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function fstem = filestemPet(pid, metric)

	switch (nargin)
		case 2
			[pid p] = ensurePid(pid);
		otherwise
			error(help('filestemPet'));
	end
	
    ho1stems = { 'p5696ho1_xr3d'                   'p5740ho1_xr3d'                  'p5760ho1_Xr3d' ...
	             'p5761ho1_xr3d' 'p5771ho1_xr3d'   'p5772ho1_xr3d' 'p5774ho1_xr3d' 'p5777ho1_xr3d' ...
	             'p5780hoXr3d'   'p5781ho1_xr3d'	 'p5784ho1_xr3d'  'p5792ho1_xr3d' 'p5807ho1_Xr3d' ...
	             'p5842ho1_xr3d'  'p5846ho1_xr3d'		            'p5856ho1_xr3d'                 }; % missing p5702, ...
	oc1stems = { 'p5696oc1Xr3d'                   'p5740oc1Xr3d'                  'p5760oc1Xr3d' ...
	             'p5761oc1_xr3d' 'p5771oc1Xr3d'	 'p5772oc1_xr3d' 'p5774oc1_xr3d' 'p5777oc1Xr3d' ...
	             'p5780ocXr3d'   'p5781oc1_xr3d'	 'p5784oc1Xr3d'  'p5792oc1_xr3d' 'p5807oc1_Xr3d' ...
                  'p5842oc1Xr3d'  'p5846oc1_xr3d'                  'p5856oc1_xr3d'                 };
	oo1stems = { 'p5696oo1_xr3d'                   'p5740oo1_xr3d'                  'p5760oo1_Xr3d' ...
	             'p5761oo1_xr3d' 'p5771oo1_xr3d'	 'p5772oo1_xr3d' 'p5774oo1_xr3d' 'p5777oo1_xr3d' ...
	             'p5780ooXr3d'   'p5781oo1_xr3d'	 'p5784oo1_xr3d'  'p5792oo1_xr3d' 'p5807oo1_Xr3d' ...
                  'p5842oo1_xr3d'  'p5846oo1_xr3d'                  'p5856oo1_xr3d'                 };
	
	if (2 == p)
		warning(['filestemPet:  ho1 data is missing for pid ' pid]); end
		
	switch (metric)
		case {'cbf', 'ho1'}
            if (strcmp('np287',pid2np(pid))) fstem = ho1stems{p}; 
			else fstem = [pid 'ho1_xr3d']; end
		case {'cbv', 'oc1'}
            if (strcmp('np287',pid2np(pid))) fstem = oc1stems{p};
            else fstem = [pid 'oc1_xr3d']; end
		case {'oef', 'oo1'}
            if (strcmp('np287',pid2np(pid))) fstem = oo1stems{p};
            else fstem = [pid 'oo1_xr3d']; end
		otherwise
			error(['filestemPet:  could not recognize metric ' metric]);
	end
	
	

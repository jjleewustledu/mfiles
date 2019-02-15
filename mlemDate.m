%
%  USAGE:  [arg1_out arg2_out] = mlemDate(arg1_in, arg2_in)
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

function dat = mlemDate(pid)

	switch (nargin)
		case 1
			assert(ischar(pid));
		otherwise
			error(help('mlemDate'));
    end
    VIDS  = { 'vc1535'    'vc1563'   'vc1645'    'vc4103'    'vc4153'    'vc4336'   'vc4354'    'vc4405'     'vc4420'   'vc4426' ...
              'vc4437'    'vc4497'   'vc4500'    'vc4520'    'vc4634'    'vc4903'   'vc5591'    'vc5625'     'vc5647'   'vc5821'};
	DATES = { '2008-1-15' '2008-3-6' ''          '2008-3-9'  '2008-3-9'  '2008-3-9' '2008-3-10' '2008-12-18' '2008-3-9' '2008-3-9' ...
	          '2008-3-9'  '2009-4-9' '2009-4-16' '2008-3-10' '2008-3-10' '2008-3-9' '2008-3-9'  '2008-3-9'   ''         '2008-2-3'};
	dbase = mlfsl.Np797Registry.instance;
    for p = 1:length(DATES)
		if (strcmpi(VIDS{p}, pid) || ...
            strcmpi(VIDS{p}, dbase.pnum2vnum(pid)))
			dat = ['_' DATES{p}]; end
	end
	
	
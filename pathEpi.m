%
%  USAGE:  pth = pathEpi(pid)
%
%          pid:		string of form 'vc4354' or the corresponding int index
%          			from pidList
%
%          pth:		string containing absolute unix path to EPI study
%
%  Created by John Lee.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function pth = pathEpi(pid)

[pid p] = ensurePid(pid);

switch (pid2np(pid))
    case 'np287'
        pth = [db('basepath', 'np287') pid '/4dfp/'];
    case 'np797'
        pth = [db('basepath', 'np797') pid '/4dfp/'];
    otherwise
        error('mfiles:InputArgErr', ...
            ['pathEp could not recognize pid2np(' pid ') -> ' pid2np(pid)]);
end



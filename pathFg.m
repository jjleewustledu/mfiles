%
%  USAGE:  pth = pathFg(pid)
%
%          pid:		string of form 'vc4354' or the corresponding int index
%          			from pidList
%
%          pth:		string containing absolute unix path to fg ROIs
%
%  Created by John Lee.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function pth = pathFg(pid)

[pid p] = ensurePid(pid);

switch (pid2np(pid))
    case 'np287'
        pth = [db('basepath', 'np287') pid '/ROIs/Xr3d/'];
    case 'np797'
        pth = [db('basepath', 'np797') pidFolder(pid) '/fsl/'];
    otherwise
        error('mfiles:InputArgErr', ...
            ['pathFg could not recognize pid2np(' pid ') -> ' pid2np(pid)]);
end
    


%
%   Usage:  [fg epi] = getFg(sizes, pathfg, pathepi, pid, study)
%
%_________________________________________________________

function [fg epi] = getFg(sizes, pathfg, pathepi, pid, study)

    switch (nargin)
        case 5
		otherwise
			error(help('getFg'));
    end
    
    epiSState = 4;
    [pid p]   = ensurePid(pid, study);
    
    try
        loaded = mlfourd.NIfTI.load([pathfg 'fg.4dfp']);
        fg = loaded.img;
    catch ME1
        disp(ME1.message);
        try
            loaded = mlfourd.NIfTI.load([pathfg 'fg.4dbool']);
            fg = loaded.img;
        catch ME2
            disp(ME2.message);
            disp('getFg:  creating fg ab initio');
            epi        = getEpi(pid, study);
            [fg fgnii] = makefg2(epi(:,:,:,epiSState), sizes);
            save_nii(fgnii, [pathfg 'fg']);
        end        
    end

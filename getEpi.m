
%  USAGE:  epi = getEpi(pid)
%
%          pid:		string of form 'vc4354' or the corresponding int index
%                   from pidList
function epi = getEpi(pid, ignore)

    DEBUG      = 1;
    EPI_FRAMES = 60;
    
    switch (nargin)
        case 1
        case 2            
		otherwise
			error(help('getEpi'));
    end
    sizes    = peek4dfpSizes(pid2np(pid));
    sizes(4) = EPI_FRAMES;    
	pid      = ensurePid(pid);
    suffix   = '.4dfp.img';
    switch (pid2np(pid))
        case 'np287'
            epipath   = [db('basepath', pid2np(pid)) pid '/4dfp/'];
            filestems = { ...
                'perfusionVenous_xr3d' ...
                'perfusion_venous_xr3d' ...
                'ep2d_perf_xr3d' };
        case 'np797'
            epipath   = [db('basepath', pid2np(pid)) pidFolder(pid) '/4dfp/'];
            filestems = { 'ep2d_perf_xr3d' };
        otherwise
            error('getEpi:InternalErr', ...
                 ['getEpi:  could not recognize study ' pid2np(pid) '; possibly a problem with ' pid '?']);
    end

    for i = 1:size(filestems,2)
        try
            fqfn = [epipath filestems{i} suffix];
            disp(['trying to find EPI 4dfp data in ' fqfn]);
            epi  = read4d(fqfn,'ieee-be','single', ...
                          sizes(1),sizes(2),sizes(3),EPI_FRAMES,0,0,0); 
            break;
        catch ME
            if (DEBUG)
                disp(ME.message); end
            epi = false;
        end
    end
    
    if (~epi)
        error('getEpi:ReadErr', ['getEpi could not find EPI data in ' epipath]); end
    


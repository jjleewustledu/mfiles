%
%  USAGE:  t1w = getT1w(pid, study)
%
%          pid:		string of form 'vc4354' or the corresponding int index
%                   from pidList
%          study:   string of form 'np797' (optional)
%
%  $Id$
%________________________________________________________________________

function t1w = getT1w(pid, study)

    QUIET = 0;
    
    switch (nargin)
        case 1
            study = pid2np(pid);
        case 2            
		otherwise
			error(help('getT1w'));
    end
    
	[pid p] 	= ensurePid(pid);
    suffix      = '.4dfp.img';
    sizes       = peek4dfpSizes(study);
    t1wTemplate = newim(sizes(1),sizes(2),sizes(3),1);
    switch (study)
        case 'np287'
            t1wpath  = [peekDrive() '/perfusion/vc/' pid '/T1cbv/'];
            filestems = { ...
                'T1cbv_on_perfusionVenous_xr3d' ...
                'T1cbv_on_perfusion_venous_xr3d' ...
                'T1Cbv_on_perfusionVenous_xr3d' ...
                't1cbv_on_perfusionVenous_xr3d' ...
                'T1cbv_on_perfusion_venous_xr3d_frame0' ...
                'T1cbv_post_on_perfusionVenous_xr3d' ...
                't1pre_on_perfusionVenous_xr3d' ...
                't1post_on_perfusionVenous_xr3d' ...
                'T1pre_on_perfusionVenous_xr3d' ...
                'T1post_on_perfusionVenous_xr3d' ...
                'T1pre_on_perfusionVenous_xr3d' ...
                'T1cbv_post_on_perfusionVenous_xr3d' ...
                'T1precbv_on_perfusionVenous' ...
                'prebolus3_on_perfusionVenous_xr3d' ...
                ['prebolus4_on_' pid '_EPI'] ...
                ['prebolus4_on_' pid '_EPI']};
        case 'np797'
            t1wpath  = [peekDrive() '/np797/' pid '/4dfp/'];
            filestems = { ...
                't1_mpr_on_ep2d_perf_r3d' ...
                't1_mpr_on_ep2d_perf_xr3d' ...
                't1_mpr_xr3d' ...
                'mprage_xr3d' };
        otherwise
            error(['getEpi:  could not recognize study ' study]);
    end

	disp(['trying to find T1-weighted 4dfp data in ' t1wpath]);
    for i = 1:size(filestems,2)
        try
            t1w = read4d([t1wpath filestems{i} suffix],'ieee-be','single',...
                          sizes(1),sizes(2),sizes(3),1,0,0,0); 
            break;
        catch ME
            if ~QUIET, disp(['getT1w:  could not find ' t1wpath filestems{i} suffix]); end
            t1w = 0;
        end
    end
    
    if (~t1w)
        error(['getT1w could not find ' t1wpath ' * ' suffix]);
    end
    t1w = squeeze(t1w);
    

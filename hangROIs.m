%
%  USAGE:     [overlays rois] = hangROIs(pid, rois)
%             overlays is a cell-array of dipimage overlays
%             pid is a string, e.g., 'vc4420', or integer
%             rois is a cell-array of dipimage ROIs (optional)
%             modified rois are returned
%
%  SYNOPSIS:  displays ROIs overlaid on T1w anatomy 
%             according to a hanging protocol
%
%  SEE ALSO:  get7Rois, peekT1w
%
%________________________________________________________________________

function [overlays rois] = hangROIs(pid, rois)

	sizes = db('sizes3d', pid2np(pid));	
	switch (nargin)
		case 1
			rois   = get7Rois(pid, roiSuffix(pid));
		case 2
			chksum = sum(rois.fg);
		    chkfg  = getFg(sizes, pathFg(pid), pathEpi(pid)); 
			if (chksum ~= sum(chkfg))
				if (isa(pid, 'double')) pid = num2str(pid); end
				error(['Oops:  pid ' pid ' is not consistent with the passed ROIs']);
			end
		otherwise
			error(help('hangROIs'));
    end	
    [pid idx]           = ensurePid(pid);
    
	[fgOl t1w]          = peekT1w(pid, rois.fg);
    [caudateOl t1w]     = peekT1w(pid, rois.caudate);
    [putamenOl t1w]     = peekT1w(pid, rois.putamen);
    [thalamusOl t1w]    = peekT1w(pid, rois.thalamus);
    [whiteOl t1w]       = peekT1w(pid, rois.white);
    [csfOl t1w]         = peekT1w(pid, rois.csf);
    [greyOl t1w]        = peekT1w(pid, rois.grey);
    [arteriesOl t1w]    = peekT1w(pid, rois.arteries);
	
	overlays.fgOl       = fgOl;
    overlays.caudateOl  = caudateOl;
    overlays.putamenOl  = putamenOl;
    overlays.thalamusOl = thalamusOl;
    overlays.whiteOl    = whiteOl;
    overlays.csfOl      = csfOl;
    overlays.greyOl     = greyOl;
    overlays.arteriesOl = arteriesOl;
	overlays.t1w        = t1w;



	% Remove any previous links
	dipfig -unlink

	% needed for figure positions; after dipinit.m

	% window sizes
	dipinit_ws = [dipgetpref('DefaultFigureWidth'),dipgetpref('DefaultFigureHeight')];

	% First link (we'll use this window to measure outer size of windows)
	dipinit_h = dipfig(50,'t1w',[100,100,dipinit_ws]);
	drawnow; % for the benefit of MATLAB 7.0.1 on Windows XP
	pause(0.5) % kludge

	% sizes of windowed GUIs
	dipinit_sp = get(dipinit_h,'OuterPosition');
	dipinit_trm = dipinit_sp(3:4)+dipinit_sp(1:2)-[100,100]-dipinit_ws;
	dipinit_sp = dipinit_sp(3:4);

	% adjusted viewport screen size
	dipinit_ss = get(0,'ScreenSize');
	dipinit_ss = dipinit_ss(3:4);
	dipinit_ss = dipinit_ss-dipinit_trm-dipinit_ws;

	pos = dipinit_sp;
	ws  = dipinit_ws;

	% adjust patient index, image slice
	sl  = -1;
	while (idx < 1 | idx > 19)
	    idx = input('Which patient index? [1..19]? ');
	end
	if (sl < 0 | sl > 7) sl = slice1(idx); end
	if (sl < 0 | sl > 7) sl = slice2(idx); end
	disp(['sl -> ' num2str(sl)]); %%% having problems getting sl from slice*
	while (sl < 0 | sl > 7)
	    sl = input('Which z-slice [0..7]? ');
    end
	disp(['displaying slice ' num2str(sl)]);
    
    % arrange figures on screen
	%                                      column --V   V-- row
	set(dipinit_h,'position',     [dipinit_ss-pos.*[2,0.2],ws]); %%%dipmapping(50,'percentile','slice',sl);
	dipfig(51,'caudateOl',        [dipinit_ss-pos.*[2,0.2],ws]); dipmapping(51,'percentile','slice',sl);
	dipfig(52,'putamenOl',        [dipinit_ss-pos.*[1,0.2],ws]); dipmapping(52,'percentile','slice',sl);
	dipfig(53,'thalamusOl',       [dipinit_ss-pos.*[0,0.2],ws]); dipmapping(53,'percentile','slice',sl);
	dipfig(54,'whiteOl',          [dipinit_ss-pos.*[2,1.2],ws]); dipmapping(54,'percentile','slice',sl);
	dipfig(55,'csfOl',            [dipinit_ss-pos.*[1,1.2],ws]); dipmapping(55,'percentile','slice',sl);
	dipfig(56,'greyOl',           [dipinit_ss-pos.*[0,1.2],ws]); dipmapping(56,'percentile','slice',sl);
	dipfig(57,'arteriesOl',       [dipinit_ss-pos.*[2,2.2],ws]); dipmapping(57,'percentile','slice',sl);
	dipfig(58,'fgOl',             [dipinit_ss-pos.*[1,2.2],ws]); dipmapping(58,'percentile','slice',sl);
	dipfig(59,'t1w',              [dipinit_ss-pos.*[0,2.2],ws]); dipmapping(59,'percentile','slice',sl);
	
    % display dipimages
	fgOl
	caudateOl
	putamenOl
	thalamusOl
	whiteOl
	csfOl
	greyOl
	arteriesOl
	t1w
	


	% Clear local variables - this is necessary because this is a script
	clear dipinit_*
	clear pos ws idx
	% Note how all variables start with '_dipinit_'. This is to avoid conflicts with
	% any variables you might have defined in your base workspace, where this script
	% executes.

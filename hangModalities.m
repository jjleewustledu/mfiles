%
%  USAGE:     [overlays rois] = hangModalities(pid, rois)
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
%  $Id$
%________________________________________________________________________

function [overlays rois] = hangModalities(pid, rois)

	sizes = db('sizes3d', pid2np(pid));	
	switch (nargin)
		case 1
			rois   = get7Rois(pid, roiSuffix(pid));
		case 2
			chksum = sum(rois.fg);
		    chkfg  = getFg(sizes, pathFg(pid), pathEpi(pid), pid); 
			if (chksum ~= sum(chkfg))
				if (isa(pid, 'double')) pid = num2str(pid); end
				error(['Oops:  pid ' pid ' is not consistent with the passed ROIs']);
			end
		otherwise
			error(help('hangModalities'));
    end	
    [pid idx]           = ensurePid(pid);
	
    [t1wOl         t1w] = peekT1w(pid);
	[petCbfOl   petCbf] = peekCbf(pid, 'pet',  rois.arteries);
    [laifCbfOl laifCbf] = peekCbf(pid, 'laif', rois.arteries);
    [mlemCbfOl mlemCbf] = peekCbf(pid, 'mlem', rois.arteries);
    [petCbvOl   petCbv] = peekCbv(pid, 'pet',  rois.arteries);
    [laifCbvOl laifCbv] = peekCbv(pid, 'laif', rois.arteries);
    [mlemCbvOl mlemCbv] = peekCbv(pid, 'mlem', rois.arteries);
    [petMttOl   petMtt] = peekMtt(pid, 'pet',  rois.arteries);
    [laifMttOl laifMtt] = peekMtt(pid, 'laif', rois.arteries);
    [mlemMttOl mlemMtt] = peekMtt(pid, 'mlem', rois.arteries);
	
	overlays.petCbfOl   = petCbfOl;
    overlays.laifCbfOl  = laifCbfOl;
    overlays.mlemCbfOl  = mlemCbfOl;
    overlays.petCbvOl   = petCbvOl;
    overlays.laifCbvOl  = laifCbvOl;
    overlays.mlemCbvOl  = mlemCbvOl;
    overlays.petMttOl   = petMttOl;
    overlays.laifMttOl  = laifMttOl;
    overlays.mlemMttOl  = mlemMttOl;
    
    overlays.petCbf     = petCbf;
    overlays.laifCbf    = laifCbf;
    overlays.mlemCbf    = mlemCbf;
    overlays.petCbv     = petCbv;
    overlays.laifCbv    = laifCbv;
    overlays.mlemCbv    = mlemCbv;
    overlays.petMtt     = petMtt;
    overlays.laifMtt    = laifMtt;
    overlays.mlemMtt    = mlemMtt;


	% Remove any previous links
	dipfig -unlink

	% needed for figure positions; after dipinit.m

	% window sizes
	dipinit_ws = [dipgetpref('DefaultFigureWidth'),dipgetpref('DefaultFigureHeight')];

	% First link (we'll use this window to measure outer size of windows)
	dipinit_h = dipfig(100,'t1w',[100,100,dipinit_ws]);
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
	if (sl < 0 | sl > sizes(3)-1) sl = slice1(idx); end
	if (sl < 0 | sl > sizes(3)-1) sl = slice2(idx); end
	disp(['sl -> ' num2str(sl)]); %%% having problems getting sl from slice1() & slice2()
	while (sl < 0 | sl > sizes(3)-1)
	    sl = input('Which z-slice [0..7]? '); end
	disp(['displaying slice ' num2str(sl)]);
    

    
    % arrange figures on screen
	%                                      column --V  V-- row
	set(dipinit_h,'position',      [dipinit_ss-pos.*[1,0.2],ws]); %dipmapping(50,'percentile','slice',sl);
    dipfig(101,'petCbfOl',        [dipinit_ss-pos.*[2,0.2],ws]); dipmapping(101,'percentile','slice',sl);
    dipfig(102,'petCbvOl',        [dipinit_ss-pos.*[4,0.2],ws]); dipmapping(102,'percentile','slice',sl);
    dipfig(103,'petMttOl',        [dipinit_ss-pos.*[3,0.2],ws]); dipmapping(103,'percentile','slice',sl);
	%dipfig(104,'',        [dipinit_ss-pos.*[2,0.2],ws]); dipmapping(104,'percentile','slice',sl);
	%dipfig(105,'',        [dipinit_ss-pos.*[1,0.2],ws]); dipmapping(105,'percentile','slice',sl);
	%dipfig(106,'',       [dipinit_ss-pos.*[0,0.2],ws]); dipmapping(106,'percentile','slice',sl);
    dipfig(107,'mlemCbfOl',          [dipinit_ss-pos.*[2,1.2],ws]); dipmapping(107,'percentile','slice',sl);
    dipfig(108,'mlemCbvOl',          [dipinit_ss-pos.*[4,1.2],ws]); dipmapping(108,'percentile','slice',sl);
    dipfig(109,'mlemMttOl',          [dipinit_ss-pos.*[3,1.2],ws]); dipmapping(109,'percentile','slice',sl);
	%dipfig(110,'',          [dipinit_ss-pos.*[2,1.2],ws]); dipmapping(110,'percentile','slice',sl);
	%dipfig(111,'',            [dipinit_ss-pos.*[1,1.2],ws]); dipmapping(111,'percentile','slice',sl);
	%dipfig(112,'',           [dipinit_ss-pos.*[0,1.2],ws]); dipmapping(112,'percentile','slice',sl);
    dipfig(113,'laifCbfOl',       [dipinit_ss-pos.*[2,2.2],ws]); dipmapping(113,'percentile','slice',sl);
    dipfig(114,'laifCbvOl',       [dipinit_ss-pos.*[4,2.2],ws]); dipmapping(114,'percentile','slice',sl);
    dipfig(115,'laifMttOl',       [dipinit_ss-pos.*[3,2.2],ws]); dipmapping(115,'percentile','slice',sl);
	%dipfig(116,'',       [dipinit_ss-pos.*[2,2.2],ws]); dipmapping(116,'percentile','slice',sl);
	%dipfig(117,'',             [dipinit_ss-pos.*[1,2.2],ws]); dipmapping(117,'percentile','slice',sl);
	%dipfig(118,'',              [dipinit_ss-pos.*[0,2.2],ws]); dipmapping(118,'percentile','slice',sl);
	
    % display dipimages
	petCbfOl
    petCbvOl
    petMttOl
	mlemCbfOl
    mlemCbvOl
    mlemMttOl
	laifCbfOl
    laifCbvOl
    laifMttOl
	


	% Clear local variables - this is necessary because this is a script
	clear dipinit_*
	clear pos ws idx
	% Note how all variables start with '_dipinit_'. This is to avoid conflicts with
	% any variables you might have defined in your base workspace, where this script
	% executes.

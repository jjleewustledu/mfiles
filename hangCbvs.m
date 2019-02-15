%HANGCBVS
%
%  USAGE:  hangCbvs(idx)
%          idx is an integer
%
%  SYNOPSIS:  displays deconvolutions, Bayes, oc1, t1s and overlaid ROIs
%             according to a hanging protocol
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function hangCbvs(idx)

if ~isnumeric(idx), idx = pidList(idx); end

%[cbfMlem, cbfOsvd, cbfSsvd, FBayes, ho1, ho1gauss, t1s,...
%    cbfSsvd_rois, FBayes_rois, ho1gauss_rois, t1s_rois] = peekPatientCbfs(idx);

cbvMlem                    = peekPerfusion(idx, 'cbvMlem', 0, [0,0], 'dip');
cbvOsvd                    = peekPerfusion(idx, 'cbvOsvd', 0, [0,0], 'dip');
cbvSsvd                    = peekPerfusion(idx, 'cbvSsvd', 0, [0,0], 'dip');
try
    CBV                    = peekPerfusion(idx, 'CBV_Int', 0, [0,0], 'dip');
catch
    CBV                    = peekPerfusion(idx, 'CBV_INT', 0, [0,0], 'dip');
end
oc1                        = peekPerfusion(idx, 'oc1',     0, [0,0], 'dip');
oc1gauss                   = peekPerfusion(idx, 'oc1',     0, [5,1], 'dip');
[grey, basal, white, rois] = peekRois(idx, 'allrois', 'dip');
rois = rois > 0;
[t1s, t1s_rois]            = peekT1s(idx, rois);
cbvSsvd_rois               = peekOverlayROIs(cbvSsvd, rois, 'cbvSsvd');
CBV_rois                   = peekOverlayROIs(CBV, rois, 'CBV');
oc1gauss_rois              = peekOverlayROIs(oc1gauss, rois, 'oc1');



% Remove any previous links
dipfig -unlink

% needed for figure positions; after dipinit.m

% window sizes
dipinit_ws = [dipgetpref('DefaultFigureWidth'),dipgetpref('DefaultFigureHeight')];

% First link (we'll use this window to measure outer size of windows)
dipinit_h = dipfig(50,'cbvMlem',[100,100,dipinit_ws]);
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

% the general scheme to follow:

% set(dipinit_h,'position',[dipinit_ss-dipinit_sp.*[1,0],dipinit_ws]);
% dipfig(11,'b',           [dipinit_ss-dipinit_sp.*[0,0],dipinit_ws]);
% dipfig(12,'c',           [dipinit_ss-dipinit_sp.*[1,1],dipinit_ws]);
% dipfig(13,'d',           [dipinit_ss-dipinit_sp.*[0,1],dipinit_ws]);
% dipfig(14,'ans',         [dipinit_ss-dipinit_sp.*[1,2],dipinit_ws]);
% dipfig(15,'other',       [dipinit_ss-dipinit_sp.*[0,2],dipinit_ws]);

pos = dipinit_sp;
ws  = dipinit_ws;

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

set(dipinit_h,'position', [dipinit_ss-pos.*[4,2],ws]); dipmapping(50,'percentile','slice',sl);
dipfig(51,'cbvOsvd',      [dipinit_ss-pos.*[4,1],ws]); dipmapping(51,'percentile','slice',sl);
dipfig(52,'cbvSsvd',      [dipinit_ss-pos.*[4,0],ws]); dipmapping(52,'percentile','slice',sl);
dipfig(53,'CBV',            [dipinit_ss-pos.*[3,0],ws]); dipmapping(53,'percentile','slice',sl);
dipfig(54,'oc1gauss',     [dipinit_ss-pos.*[2,0],ws]); dipmapping(54,'lin',       'slice',sl);
dipfig(55,'oc1',          [dipinit_ss-pos.*[2,1],ws]); dipmapping(55,'lin',       'slice',sl);
dipfig(59,'t1s',          [dipinit_ss-pos.*[1,0],ws]); dipmapping(59,'lin',       'slice',sl);
dipfig(56,'cbvSsvd_rois', [dipinit_ss-pos.*[5,0],ws]); dipmapping(56,'percentile','slice',sl);
dipfig(57,'CBV_rois',       [dipinit_ss-pos.*[3,1],ws]); dipmapping(57,'percentile','slice',sl);
dipfig(58,'oc1gauss_rois',[dipinit_ss-pos.*[2,2],ws]); dipmapping(58,'lin',       'slice',sl);
dipfig(60,'t1s_rois',     [dipinit_ss-pos.*[1,1],ws]); dipmapping(60,'lin',       'slice',sl);

cbvMlem
cbvOsvd
cbvSsvd
CBV
oc1
oc1gauss
t1s
cbvSsvd_rois
CBV_rois
oc1gauss_rois
t1s_rois

% Clear local variables - this is necessary because this is a script
clear dipinit_*
clear pos ws idx
% Note how all variables start with '_dipinit_'. This is to avoid conflicts with
% any variables you might have defined in your base workspace, where this script
% executes.

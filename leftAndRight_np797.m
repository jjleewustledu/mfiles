function str = leftAndRight_np797(pnum, debug)
%% LEFTANDRIGHT_NP797 ... 
%   
%  Usage:  leftAndRight_np797() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 
import mlfourd.*;

Nlaif    = 6;
mPetCbf  = 8;
modal    = { ...
    'DerivedCBF_Mean', 'DerivedCBF_Peak', 'DerivedCBF_StdDev', 'NoiseStdDev_Set_01', 'ProbModel', 'ProbSignal', ...
    'ho',              'cbf_ssvd', ...
    'qcbf',            'scbf', ...
    'pwAsl',           'pwAsl2',          'cbfPasl',           'cbfPasl2' };
for n = 1:Nlaif
    modal{n} = ['BIP_LocalAIF_MrRec_Const1_' modal{n}];
end
modalRef = { ...
    '',                '',                '',                  '',                   '',          '', ...
    'bt1_rot',         '', ...
    '',                '', ...
    '',                '',                '',                  ''  }; 
assert(length(modal) == length(modalRef));
for m = 1:length(modal)
    modal{m}= [modal{m} '_rot'];
    if (~isempty(modalRef{m}))
        modal{m} = [modal{m} '_on_' modalRef{m}];
    end
end

dlist  = dir(pwd);
dcells = cell(1,length(dlist));
for d = 1:length(dlist)
    dcells{d} = dlist(d).name;
end

roiRef = { ...
    'ep2d',    'ep2d',    'ep2d', 'ep2d', 'ep2d', 'ep2d', ...
    'bt1_rot', 'ep2d', ...
    'ep2d',    'ep2d',  ...
    'pasl',    'pasl',    'pasl', 'pasl' };
assert(length(modal) == length(roiRef));
L = 'left';   R = 'right';
rois = cell(2, length(roiRef));
for r = 1:length(roiRef)
    rois{1,r} = [L '_on_' roiRef{r}];
    rois{2,r} = [R '_on_' roiRef{r}];
end

str = '';
for m = 1:length(modal)
    if (exist('debug', 'var'))
        str = sprintf('%s%s', str, leftAndRight(modal{m}, rois{1,m}, rois{2,m}, pnum, debug));
    else
        str = sprintf('%s%s', str, leftAndRight(modal{m}, rois{1,m}, rois{2,m}, pnum));
    end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/leftAndRight_np797.m] ======  

% Usage:   [ho1, F, cbfSsvd, cbfOsvd, cbfMlem] = ...
%          scatterCbfs(ho1, F, cbfSsvd, cbfOsvd, cbfMlem)
%
%          all input arguments are optional; nonnumeric inputs are ignored
%          output arguments may be reused in subsequent calls to scatter*, if useful
%
% in effect, this is a high-level unit test
%__________________________________________________________________________

function [ho1, F, cbfSsvd, cbfOsvd, cbfMlem] =  scatterCbfs(varargin)
     
% arrange input arguments, if any
switch (nargin)
    case 0
        disp('no input arguments found; generating all plotting vectors');
    case 1
        ho1_ = varargin(1);
    case 2
        ho1_ = varargin(1);
        F_   = varargin(2);
    case 3
        ho1_     = varargin(1);
        F_       = varargin(2);
        cbfSsvd_ = varargin(3);
    case 4
        ho1_     = varargin(1);
        F_       = varargin(2);
        cbfSsvd_ = varargin(3);
        cbfOsvd_ = varargin(4);
    case 5
        ho1_     = varargin(1);
        F_       = varargin(2);
        cbfSsvd_ = varargin(3);
        cbfOsvd_ = varargin(4);
        cbfMlem_ = varargin(5);
    otherwise
        ho1_     = varargin(1);
        F_       = varargin(2);
        cbfSsvd_ = varargin(3);
        cbfOsvd_ = varargin(4);
        cbfMlem_ = varargin(5);
        warning('extra input arguments will be ignored');
end



% for all available patient data
if nargin > 0 && isnumeric(ho1_), ho1 = ho1_;
else                              ho1 = peekCoords('allrois', 'ho1'); end

% scatter may expect vectors of doubles

if nargin > 1 && isnumeric(F_), F = F_;
else                            F = peekCoords('allrois', 'F'); end
handleF_vs_ho1 = scatter(ho1, F);
clear F;

if nargin > 2 && isnumeric(cbfSsvd_), cbfSsvd = cbfSsvd_;
else                                  cbfSsvd = peekCoords('allrois', 'cbfSsvd'); end
handleF_vs_cbfSsvd = scatter(ho1, cbfSsvd);
clear cbfSsvd;

if nargin > 3 && isnumeric(cbfOsvd_), cbfOsvd = cbfOsvd_;
else                                  cbfOsvd = peekCoords('allrois', 'cbfOsvd'); end
handleF_vs_cbfOsvd = scatter(ho1, cbfOsvd);
clear cbfSsvd;

if nargin > 4 && isnumeric(cbfMlem_), cbfMlem = cbfMlem_(5);
else                                  cbfMlem = peekCoords('allrois', 'cbfMlem'); end
handleF_vs_cbfMlem = scatter(ho1, cbfMlem);
clear cbfMlem;

figure(handleF_vs_ho1)
figure('Name','F vs. ho1',         'NumberTitle','off')
figure(handleF_vs_cbfSsvd)
figure('Name','CBF (SSVD) vs. ho1','NumberTitle','off')
figure(handleF_vs_cbfOsvd)
figure('Name','CBF (OSVD) vs. ho1','NumberTitle','off')
figure(handleF_vs_cbfMlem)
figure('Name','CBF (MLEM) vs. ho1','NumberTitle','off')
findfigs


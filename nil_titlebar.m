%NIL_TITLEBAR(FIG,UDATA)
%    Updates the title bar of FIG.

% (C) Copyright 1999-2000               Pattern Recognition Group
%     All rights reserved               Faculty of Applied Physics
%                                       Delft University of Technology
%                                       Lorentzweg 1
%                                       2628 CJ Delft
%                                       The Netherlands
%
% Cris Luengo, November 2000.

function nil_titlebar(fig,udata)
tit = udata.imname;
if isfield(udata,'curslice')
   tit = [tit,' (',num2str(udata.curslice),')'];
end
if isfield(udata,'zoom') & ~isempty(udata.zoom) & udata.zoom~=0
   tit = [tit,' (',num2str(udata.zoom*100),'%)'];
end
set(fig,'Name',tit);

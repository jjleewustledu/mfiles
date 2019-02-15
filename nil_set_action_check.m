%NIL_SET_ACTION_CHECK(FIG,STATE)
%    Set the checkmark to the current mouse action.

% (C) Copyright 1999-2001               Pattern Recognition Group
%     All rights reserved               Faculty of Applied Physics
%                                       Delft University of Technology
%                                       Lorentzweg 1
%                                       2628 CJ Delft
%                                       The Netherlands
%
% Cris Luengo, July 2000.
% July 2001: only clear the old checked box
% 16-26 August 2001: Changed DIPSHOW. This function changes accordingly.

function nil_set_action_check(fig,state)
m = get(findobj(get(fig,'Children'),'Tag','actions'),'Children');
tags = get(m,'Tag');
I = strncmp(tags,'mouse_',6);
m = m(I);
set(m,'Checked','off');
if ~isempty(state)
   I = find(strcmp(tags(I),['mouse_',state]));
   if ~isempty(I)
      set(m(I),'Checked','on');
   end
end

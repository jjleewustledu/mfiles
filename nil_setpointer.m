%NIL_SETPOINTER(FIG,POINTER)
%    Sets the custom pointers used throughout.

% (C) Copyright 1999-2002               Pattern Recognition Group
%     All rights reserved               Faculty of Applied Physics
%                                       Delft University of Technology
%                                       Lorentzweg 1
%                                       2628 CJ Delft
%                                       The Netherlands
%
% Cris Luengo, August 2001.
% 14 March 2002: Added hand shapes (copied from Adobe Acrobat)

function nil_setpointer(fig,pointer)
switch pointer
   case 'cross'
      pointershape = [...
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2 NaN   2 NaN NaN NaN NaN NaN NaN NaN
           2   2   2   2   2   2 NaN NaN NaN   2   2   2   2   2   2 NaN
           1   1   1   1   1 NaN NaN NaN NaN NaN   1   1   1   1   1 NaN
           2   2   2   2   2   2 NaN NaN NaN   2   2   2   2   2   2 NaN
         NaN NaN NaN NaN NaN NaN   2 NaN   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN ...
      ];
      set(fig,'PointerShapeCData',pointershape,'PointerShapeHotSpot',[8,8],'pointer','custom');
   case 'loupe'
      pointershape = [...
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   2   2 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN   2   2   1   1   1   2   2 NaN NaN NaN NaN NaN
         NaN NaN NaN   2   1   1   2   2   2   1   1   2 NaN NaN NaN NaN
         NaN NaN NaN   2   1   2 NaN NaN NaN   2   1   2 NaN NaN NaN NaN
         NaN NaN   2   1   2 NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN
         NaN NaN   2   1   2 NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN
         NaN NaN   2   1   2 NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN
         NaN NaN NaN   2   1   2 NaN NaN NaN   2   1   2 NaN NaN NaN NaN
         NaN NaN NaN   2   1   1   2   2   2   1   1   2 NaN NaN NaN NaN
         NaN NaN NaN NaN   2   2   1   1   1   2   2   1   2 NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   2   2   2 NaN NaN   2   1   2 NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   2   1   2 NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   2   1   2
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   2   2 ...
      ];
      set(fig,'PointerShapeCData',pointershape,'PointerShapeHotSpot',[8,8],'pointer','custom');
   case 'hand_open'
      pointershape = [...
         NaN NaN NaN NaN NaN NaN NaN   1   1 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN   1   1 NaN   1   2   2   1   1   1 NaN NaN NaN NaN
         NaN NaN   1   2   2   1   1   2   2   1   2   2   1 NaN NaN NaN
         NaN NaN   1   2   2   1   1   2   2   1   2   2   1 NaN   1 NaN
         NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   1   2   1
         NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   2   2   1
         NaN   1   1 NaN   1   2   2   2   2   2   2   2   1   2   2   1
           1   2   2   1   1   2   2   2   2   2   2   2   2   2   2   1
           1   2   2   2   1   2   2   2   2   2   2   2   2   2   1 NaN
         NaN   1   2   2   2   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN NaN   1   2   2   2   2   2   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN ...
      ];
      set(fig,'PointerShapeCData',pointershape,'PointerShapeHotSpot',[8,8],'pointer','custom');
   case 'hand_closed'
      pointershape = [...
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN   1   1 NaN   1   1 NaN   1   1 NaN NaN NaN
         NaN NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   1 NaN
         NaN NaN NaN NaN   1   2   2   2   2   2   2   2   2   1   2   1
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   1
         NaN NaN NaN NaN   1   1   2   2   2   2   2   2   2   2   2   1
         NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   2   2   1
         NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN ...
      ];
      set(fig,'PointerShapeCData',pointershape,'PointerShapeHotSpot',[8,8],'pointer','custom');
   case 'hand_finger'
      pointershape = [...
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN   1   1 NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   1 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   1 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   1 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   1   1 NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   1   2   1   1 NaN NaN NaN NaN
         NaN   1   1 NaN NaN   1   2   2   1   2   1   2   1   1 NaN NaN
           1   2   2   1 NaN   1   2   2   1   2   1   2   1   2   1 NaN
         NaN   1   2   2   1   1   2   2   2   2   2   2   1   2   1 NaN
         NaN NaN   1   2   2   1   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   1   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN NaN   1   2   2   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN ...
      set(fig,'PointerShapeCData',pointershape,'PointerShapeHotSpot',[7,2],'pointer','custom');
      ];
   otherwise
      error('Unknown pointer shape.')
end
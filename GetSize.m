function GetSize(obj)
%% GETSIZE ...
% https://www.mathworks.com/matlabcentral/answers/14837-how-to-get-size-of-an-object :
% There is function 'whos' that shows variables and their sizes, but for objects it shows just size of the pointer 
% (about 112 bytes). How to get real size of the object?
%
%  Created 03-Oct-2023 16:39:00 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 23.2.0.2365128 (R2023b) for MACI64.  Copyright 2023 John J. Lee.

props = properties(obj); 
totSize = 0; 

for ii=1:length(props) 
  currentProperty = getfield(obj, char(props(ii))); %#ok<NASGU>
  s = whos('currentProperty'); 
  totSize = totSize + s.bytes; 
end

fprintf(1, '%d bytes\n', totSize); 


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/GetSize.m] ======  

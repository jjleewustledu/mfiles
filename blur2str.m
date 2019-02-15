function str = blur2str(blr)
%% BLUR2STR ... 
%   
%  Usage:  string = blur2str(blur) 
%                            ^ numeric, vec

%% Version $Revision: 2417 $ was created $Date: 2013-03-14 04:21:12 -0500 (Thu, 14 Mar 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-03-14 04:21:12 -0500 (Thu, 14 Mar 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/blur2str.m $ 
%% Developed on Matlab 8.1.0.47 (R2013a) 
%% $Id$ 

if (ischar(blr))
    blr = str2double(blr);
end
assert(isnumeric(blr));

str = ''; %#ok<*NASGU>
if (blr(1) == blr(2) && blr(2) == blr(3))
	blr = blr(1);
end
for b = 1:length(blr)
    [tok,remain] = strtok(num2str(blr(b)), '.');
    if (~isempty(remain))
        tok = [tok 'p' remain(2:end)]; 
    end %#ok<*AGROW>
    str = [str tok];
    if (length(blr) > 1)
        str = [str 'x']; 
        if (b == length(blr))
            str = str(1:length(str)-1); 
        end
    end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/blur2str.m] ======  

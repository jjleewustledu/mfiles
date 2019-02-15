function pos = harlaxton(pos0)
%% HARLAXTON ... 
%   
%  Usage:  final_pos = harlaxton(init_pos) 
%          ^ <...,...,...>       ^ double 
%% Version $Revision: 2306 $ was created $Date: 2013-01-12 17:49:33 -0600 (Sat, 12 Jan 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-01-12 17:49:33 -0600 (Sat, 12 Jan 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/harlaxton.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 

if (ischar(pos0))
    patt  = '\<(?<first>\d+\.\d+),\s*(?<second>\d+\.\d+),\s*(?<third>\d+\.\d+)\>';
    names = regexpi(pos0, patt, 'names');
    pos0  = [str2double(names.first) str2double(names.second) str2double(names.third)];
end
assert(isnumeric(pos0));
nwTowerPos = [9.7424 107.889 31.5985];
preShrinkTranslation = [-24 12 -43];
pos = pos0 + preShrinkTranslation;
pos = pos  + 0.2*(nwTowerPos - pos);
pos = sprintf('<%7.4f,%8.4f,%8.4f>', pos(1), pos(2), pos(3));








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/harlaxton.m] ======  

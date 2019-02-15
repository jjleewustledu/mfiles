function token = blurstrtok(token)
%% BLURSTRTOK ... 
%  Usage:  string = blurstrtok(string) 
%          ^ only the first blur substring is excised

%% Version $Revision: 2420 $ was created $Date: 2013-04-22 13:32:32 -0500 (Mon, 22 Apr 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-04-22 13:32:32 -0500 (Mon, 22 Apr 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/blurstrtok.m $ 
%% Developed on Matlab 8.1.0.47 (R2013a) 
%% $Id$ 

SUFFIXES = cellfun(@(x) ['_' x], mlpet.PETBuilder.PREPROCESS_LIST, 'UniformOutput', false);
if (~lstrfind(token, SUFFIXES))
    return; end
for s = 1:length(SUFFIXES)
    idxs = strfind(token, SUFFIXES{s});
    if (~isempty(idxs))
        pre = token(1:idxs(1)-1);
        [~,post] = strtok(token(idxs(1):end), '_');
        token = [pre post];
    end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/blurstrtok.m] ======  

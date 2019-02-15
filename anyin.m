function tf = anyin(sset, patt)
%% NONEIN ... 
%   
%  Usage:  tf = anyin(string_set, patterns) 
%          ^ logical
%                     ^            ^ strings or cell arrays of
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/anyin.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 
    
if (iscell(patt))

    tf = false;
    for p = 1:length(patt) %#ok<*FORFLG>
        tf = tf || anyin(sset, patt{p});
    end
else

    if (iscell(sset))
        tfs = cellfun(@(x) ~isempty(x), strfind(sset, patt));
        tf  = any(tfs);
    else
        tf  = lstrfind(sset, patt);
    end
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/anyin.m] ======  

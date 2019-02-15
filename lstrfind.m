function tf = lstrfind(theTxt, patt)
%% LSTRFIND always returns a logical scalar.  
%  Returns true if the string pattern is found anywhere within the text, text may be cell-arrayed.
%  Returns true if any element of the cell-arrayed pattern is found in non-arrayed text.
%   
%  Usage:  tf = lstrfind(text, pattern) 
%                        ^ cf. doc strfind
%% Version $Revision: 2369 $ was created $Date: 2013-03-05 06:40:54 -0600 (Tue, 05 Mar 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-03-05 06:40:54 -0600 (Tue, 05 Mar 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/lstrfind.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

if (iscell(theTxt))
    tf = ~cellfun(@isempty, strfind(theTxt, patt));
else
    if (iscell(patt))
        tf = cellfun(@(x) lstrfind(theTxt, x), patt);      
        tf = cell2mat(ensureCell(tf));
    else
        tf = ~isempty(strfind(theTxt, patt));
    end
end

if (isempty(tf))
    tf = false; end
while (length(tf) > 1)
    tf = any(tf); end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/lstrfind.m] ======  

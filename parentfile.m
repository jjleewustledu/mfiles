function spth = parentfile(pth, patts)
%% PARENTFILE returns a truncated directory name using a pattern/patterns
%   
%  Usage:  parent_dir = parentfile(dir, naming_pattern) 
%                                  ^ fully-qualified  
%                                       ^ string or cell array
%                              
%% Version $Revision: 2296 $ was created $Date: 2012-12-09 19:51:00 -0600 (Sun, 09 Dec 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-12-09 19:51:00 -0600 (Sun, 09 Dec 2012) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/parentfile.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 

    assert(ischar(pth));
    patts   = ensureCell(patts);            
    ca      = regexp(pth, filesep, 'split');
    for p   = 1:length(patts) %#ok<FORFLG>
        idx = findindex(ca, patts{p}); 
        if (~isempty(idx))
            spth = filenparts(pth, idx-1);  
            break
        else
            spth = pth;
        end
    end
    if (strcmp(filesep, spth(end))); spth = spth(1:end-1); end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/parentfile.m] ======  

function [p,f,e] = filenparts(file, idx)
%% FILENPARTS adds indexing functionality to fileparts; ensures fileparts exist
%   
%  Usage:  [p,f,e] = filenparts(file[, index]) 
%           ^                   ^ strings, same as for fileparts
%                                                                 
%                                      ^ int:  default 0 returns exactly the results of fileparts
%                                        for file = /p1/p2/p3/f.e | file = /p1/p2/p3/ | file = /p1/p2/p3
%                                            index  0 returns p=/p1/p2/p3
%                                            index  1 returns p=/p1
%                                            index  2 returns p=/p1/p2
%                                            index  3 returns p=/p1/p2/p3
%                                            index  4 returns p=/p1/p2/p3
%                                            index -1 returns p=/p1/p2
%                                            index -2 returns p=/p1
%                                            index -3 returns p=/
%                                            index -4 returns p=''
%                                                                 
%  FILENPARTS throws an exception if file does not exist on the filesystem
%
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/filenparts.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

assert(isunix, 'mfiles:UnsupportedMachineType');
if (~exist('idx','var')); idx = 0; end
assert(lexist(file, 'file')); % is file or dir
if (lexist(file, 'dir')); file = [file filesep]; end
[p,f,e] = fileparts(file);
if (0 ~= idx)
    flds = regexp(p, '/', 'split');
    idx  = sign(idx)*min(abs(idx), length(flds));
end
if (idx > 0 && idx < length(flds))
    p = '';
    for fi = 1:idx+1  %#ok<*FORFLG>
        p = [p flds{fi} filesep]; %#ok<*AGROW>
    end
end
if (idx < 0)    
    p = '';
    for fi = 1:length(flds)+idx
        p = [p flds{fi} filesep];
    end
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/filenparts.m] ======  

function fns = ensureFilenamesExist(fns, varargin)
%% ENSUREFILENAMESEXIST returns a cell-array of filename strings, type-casting as needed
%   
%  Usage:  filenames = ensureFilenameExists(filenames)
%  Uses:   ensureFilenames
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/ensureFilenamesExist.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

fns = ensureFilenames(fns, varargin{:});
for f = 1:length(fns)
    assert(lexist(fns{f}, 'file'), 'mfiles:IOError', 'ensureFilenameExists could not find %s', fns);
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureFilenameExists.m] ======  

function fn = ensureFilenameExists(fn, varargin)
%% ENSUREFILENAMEEXISTS returns a filename string, type-casting as needed
%   
%  Usage:  filename = ensureFilenameExists(filename) 
%  Uses:   ensureFilename
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/ensureFilenameExists.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

fn = ensureFilename(fn, varargin{:});
assert(lexist(fn, 'file'), 'mfiles:IOError', 'ensureFilenameExists could not find %s', fn);






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureFilenameExists.m] ======  

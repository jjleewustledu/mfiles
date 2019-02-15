function backupfiles(patt, backup, varargin)
%% BACKUPFILES copies all files matching the filename pattern to a backup-folder
%  Usage:  backupfiles(filename_pattern, backup_folder, make_archive) 
%                                                       ^ logical
%% Version $Revision: 2636 $ was created $Date: 2013-09-16 01:20:51 -0500 (Mon, 16 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-16 01:20:51 -0500 (Mon, 16 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/backupfiles.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 

p  = inputParser;
addRequired(p, 'patt', @ischar);
addRequired(p, 'backup', @ischar);
addOptional(p, 'arch', true, @islogical);
parse(p, patt, backup, varargin{:});

dt = mlsystem.DirTool(p.Results.patt);
if (dt.length > 0)
    ensureFolderExists(  p.Results.backup);
    copyfiles(dt.fqfns,  p.Results.backup, 'f');
    archive(p.Results.backup);
end




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/backupfiles.m] ======  

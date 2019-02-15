function archive(folder, suffix)
%% ARCHIVE creates a bzipped2-tar archive of a specified folder.
%  If the OS is Mac OS and archiving completed without errors, then archive will move the folder into Trash
%  Usage:  archive(folder_name, archive_suffix) 
%                  ^            ^ strings 
%  Requires:  http://www.dribin.org/dave/osx-trash/, http://rubyforge.org/projects/osx-trash/
%% Version $Revision: 2636 $ was created $Date: 2013-09-16 01:20:51 -0500 (Mon, 16 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-16 01:20:51 -0500 (Mon, 16 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/archive.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 

    if (~lexist(folder, 'dir'))
        return; end
    if (~exist('suffix','var'))
        suffix = ''; end
    assert(ismac);
    assert(lexist('/usr/bin/trash', 'file'));
    probs = true;
    try
        [prefolder,foldername] = fileparts(folder);
        if (isempty(prefolder))
            prefolder = fullfile(folder, '..', ''); end
        if (~isempty(suffix) && ~lstrfind(suffix, '_'))
            suffix = ['_' suffix]; end
        %probs = 
        mlbash(sprintf('pushd %s; tar -cf - %s |bzip2> %s%s.tbz; popd', prefolder, foldername, foldername, suffix));
    catch ME
        warning('mfiles:bashError', ME.message);
    end
    %if (~probs)
    %   mlbash(sprintf('/usr/bin/trash %s', folder)); 
    %end









% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/archive.m] ======  

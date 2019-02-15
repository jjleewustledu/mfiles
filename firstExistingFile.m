function frst = firstExistingFile(comPath, cells)
    %% FIRSTEXISTINGFILE ...
    %  Usage:  found_file = firstExistingFile(common_path, cells_of_filenames) 
    %          ^                                           ^ cell-array of filenames
    %          return first exisiting file/folder, else throw exception
    %% Version $Revision: 2551 $ was created $Date: 2013-08-22 04:37:16 -0500 (Thu, 22 Aug 2013) $ by $Author: jjlee $,  
    %% last modified $LastChangedDate: 2013-08-22 04:37:16 -0500 (Thu, 22 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/firstExistingFile.m $ 
    %% Developed on Matlab 7.14.0.739 (R2012a) 
    %% $Id$ 

    assert(lexist(comPath, 'dir'));
    cells = ensureCell(cells);
    checkComPath;
    frst = '';
    for c = 1:length(cells)
        fn = fullfile(comPath, cells{c});
        if (lexist(fn, 'file'))
            frst = fn;
            break;
        end
    end
    if (isempty(frst))
        error('mfiles:IOError:FileNotFound', 'not found:  %s', cell2str(cells));
    end

    function checkComPath
        if (lstrfind(comPath, [cells 'fsl']))
            comPath = fileparts(comPath);
        end
    end

end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/firstExistingFile.m] ======  

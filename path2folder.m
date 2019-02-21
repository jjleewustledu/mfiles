function fld  = path2folder(pth)
    assert(lexist(pth, 'dir'));
    [~,fld] = filepartsx(pth, mlfourd.NIfTIInfo.FILETYPE_EXT);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/path2folder.m] ======  

function pth  = parentPath(pth)
    assert(lexist(pth, 'dir'));
    pth = fileparts(pth);
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/parentPath.m] ======  

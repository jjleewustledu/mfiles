function mnum   = str2mnum(str)
    %% STR2MNUM returns the mnumber, M123, from an arbitrary string using regexp            

    names = regexp(str, '(?<mnum>M\d\d\d)', 'names');
    if (isempty(names))
        warning('mfiles:regexpNotFound', 'str2mnum(''%s'')', str);
        mnum = '';
        return
    end
    mnum  = names.mnum;
end




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/str2pnum.m] ======  

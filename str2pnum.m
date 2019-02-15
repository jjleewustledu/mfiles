function pnum   = str2pnum(str)
    %% PNUMBER returns the pnumber, p1234, from an arbitrary string using regexp            

    names  = regexp(str, '(?<pnum>p\d\d\d\d)', 'names');
    names2 = regexp(str, '(?<pnum>M\d\d\d)', 'names');
    if (~isempty(names))
        pnum = names.pnum;
        return
    end
    if (~isempty(names2))
        pnum = names2.pnum;
        return
    end
    
    warning('mfiles:regexpNotFound', 'str2pnum(''%s'')', str);
    pnum = '';
end




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/str2pnum.m] ======  

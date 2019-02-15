function mmnum   = str2mmnum(str)
    %% PNUMBER returns the pnumber, p1234, from an arbitrary string using regexp            

    names = regexp(str, '(?<mmnum>mm\d\d-\d\d\d)', 'names');
    mmnum  = names.mmnum;
end




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/str2pnum.m] ======  

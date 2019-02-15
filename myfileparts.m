function [pth,prefix,ext] = myfileparts(fstr)
%% MYFILEPARTS extends fileparts to regard myfileparts.SUFFIXES as single file extensions.
%  @param fstr is char or cell; cell with length == 1 is interpreted as char.
%  @return pth.
%  @return prefix.
%  @return ext.

SUFFIXES = {'.4dfp.img.rec' '.4dfp.img' '.4dfp.ifh' '.4dfp.hdr' '.img.rec' '.hdr.info' '.log' '.nii.gz' '.v.hdr' '.v.mhdr' '.v'};

if (iscell(fstr))
    if (length(fstr) > 1)
        pth    = cell(1,length(fstr)); 
        prefix = cell(1,length(fstr)); 
        ext    = cell(1,length(fstr));
        for f = 1:length(fstr)
            [pth{f},prefix{f},ext{f}] = myfileparts(fstr{f});
        end
        return
    end
    fstr = fstr{1};
end
for s = 1:length(SUFFIXES)
    if (lstrfind(fstr, SUFFIXES{s}))
        [pth,prefix,ext] = filepartsx(fstr, SUFFIXES{s});
        return
    end
end
[pth,prefix,ext] = fileparts(fstr);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/myfileparts.m] ======  

end

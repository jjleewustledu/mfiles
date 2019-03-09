function [pth,prefix,ext] = myfileparts(fstr)
%% MYFILEPARTS extends fileparts to regard myfileparts.SUFFIXES as single file extensions.
%  It protects trailing floating point numbers such as "/path/to/file_tagged_1.23".
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

% base cases

% recognized SUFFIXES
for s = 1:length(SUFFIXES)
    if (lstrfind(fstr, SUFFIXES{s}))
        [pth,prefix,ext] = filepartsx(fstr, SUFFIXES{s});
        return
    end
end

% trivial
[pth,prefix,ext] = fileparts(fstr);

% check for floating-point at end
pe = [prefix ext];
r = regexp(pe, '\d+\.\d+', 'match');
if (~isempty(r)) % found f.p.
    idx_f = strfind(pe, r{end}) + length(r{end}) - 1; % end idx of f.p.
    if (idx_f > length(prefix)) % f.p. extends into ext
        prefix = pe;
        ext = '';
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/myfileparts.m] ======  

end

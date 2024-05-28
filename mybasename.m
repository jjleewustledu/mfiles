function bn = mybasename(str, opts)
%% MYBASENAME 
%  Args:
%      str (text): represents any filesystem string.
%  Returns:
%      bn: is a basename extracted from str ~ '/path/to/basename.ext'.
%  Usage:
%      >> mybasename('/path/to/fileprefix.nii.gz')
%      ans =
%          'fileprefix'
%     
%      >> mybasename(["/path/to/filprefix.nii.gz" "/path/to/another/fileprefix.nii.gz"])
%      ans = 
%        1×2 string array
%          "filprefix"    "fileprefix"
%
%  Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 

arguments
    str {mustBeTextScalar}
    opts.withext logical = false
end

if iscell(str)
    bn = cell(size(str));
    for is = 1:length(str)
        bn{is} = mybasename(str{is});
    end
    return
end

% base case

if isfolder(str)
    [~,bn1,bn2] = myfileparts(str);
    bn = strcat(bn1, bn2);
    return
end

if endsWith(str, filesep)
    str = extractBefore(str, strlength(str));
end
[~,bn, ext] = myfileparts(str);
if opts.withext
    bn = strcat(bn, ext);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/mybasename.m] ======  

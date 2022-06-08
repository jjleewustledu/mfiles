function fqfp = myfileprefix(str)
%% MYFILEPREFIX removes file extensions.
%  Args:
%      str (text):  e.g., /path/to/fileprefix.ext
%  Returns:
%      fqfp:  e.g., /path/to/fileprefix
%  Usage:
%     >> myfileprefix('/path/to/fileprefix.nii.gz')
%     ans =
%         '/path/to/fileprefix'
%     >> myfileprefix(["/path/to/f1.nii.gz" "/path/to/f2.nii.gz"])
%     ans = 
%       1×2 string array
%
%  Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 

if isempty(str) || "" == str
    fqfp = str;
    return
end

[pth,fp] = myfileparts(str);
fqfp = fullfile(pth, fp);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/myfileprefix.m] ======  

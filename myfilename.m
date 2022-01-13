function fn = myfilename(varargin)
%% MYFILENAME changes file extensions.
%  Args:
%     name (text): represents any filesystem text.
%     ext (text): is the optional file extension to enforce.  Default:  do not alter file extensions.
%  Returns:
%     fn (text): a filename with new file extension, created from name + ext.
%  Usage:
%     >> myfilename('/path/to/filprefix.nii.gz', '.4dfp.hdr')
%     ans =
%         '/path/to/filprefix.4dfp.hdr'
%
%     >> myfilename(["/path/to/filprefix.nii.gz" "/path/to/another/fileprefix.nii.gz"], '.4dfp.hdr')
%     ans = 
%       1×2 string array
%         "/path/to/filprefix.4dfp.hdr"    "/path/to/another/fileprefix.4dfp.hdr"
%
%  Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 

ip = inputParser;
addRequired(ip, "name", @istext);
addOptional(ip, "ext", "", @istext); 
parse(ip, varargin{:});
ipr = ip.Results;
ipr.name = convertCharsToStrings(ipr.name);
ipr.ext = convertCharsToStrings(ipr.ext);

if 0 == strlength(ipr.ext)
    fn = ipr.name;
    return
end
if ~strncmp(ipr.ext, ".", 1)
    ipr.ext = "." + ipr.ext;
end
[pth,fp] = myfileparts(ipr.name);
fn = fullfile(pth, fp + ipr.ext);
if ischar(ip.Results.name) && ischar(ip.Results.ext)
    fn = convertStringsToChars(fn);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/myfilename.m] ======  

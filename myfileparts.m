function [pth,fp,x] = myfileparts(str)
%% MYFILEPARTS extends fileparts to recognize multi-dotted SUFFIXES as file extensions.
%  It also preserves trailing floating point numbers such as "/path/to/file_tagged_1.23".
%  Args:
%      str (text): may be a fully-qualified filename.
%  Returns:
%      pth: is the path matching the type of str.
%      fp: is the file prefix matching the type of str.
%      x: is the file extension matching the type of str.
%  Usage:
%     >> [a,b,c] = myfileparts('/path/to/fileprefix.nii.gz')
%     a =
%         '/path/to'
%     b =
%         'fileprefix'
%     c =
%         '.nii.gz'
%     
%     >> [a,b,c] = myfileparts({'/path/to/fileprefix1.nii.gz' '/path/to/fileprefix2.nii.gz'})
%     a =
%       1×2 cell array
%         {'/path/to'}    {'/path/to'}
%     b =
%       1×2 cell array
%         {'fileprefix1'}    {'fileprefix2'}
%     c =
%         '.nii.gz'
%     
%     >> [a,b,c] = myfileparts(["/path/to/fileprefix1.nii.gz" "/path/to/fileprefix2.nii.gz"])
%     a = 
%       1×2 string array
%         "/path/to"    "/path/to"
%     b = 
%       1×2 string array
%         "fileprefix1"    "fileprefix2"
%     c = 
%         ".nii.gz"    

str_ = convertCharsToStrings(str);
if "" == str_
    pth = "";
    fp = "";
    x = "";
    if ischar(str) || iscellstr(str)
        [pth,fp,x] = convertStringsToChars(pth, fp, x);
    end
    return
end

% multi-dotted SUFFIXES
SUFFIXES = [ ...
    ".4dfp.img.rec" ".4dfp.img" ".4dfp.ifh" ".4dfp.hdr" ".4dfp.*"...
    ".img.rec" ".hdr.info" ".nii.gz" ".v.hdr" ".v.mhdr" ".v.*" ".dcm" ".dcm.json" ".bf" ".ptd" ".ptr"];
for s = 1:length(SUFFIXES)
    if endsWith(str_, SUFFIXES(s))
        [pth,fp,x] = fileparts(str_);
        fp = extractBefore(fp + x, SUFFIXES(s));
        x = SUFFIXES(s);
        if ischar(str) || iscellstr(str) %#ok<*ISCLSTR> 
            [pth,fp,x] = convertStringsToChars(pth, fp, x);
        end
        return
    end
end

[pth,fp,x] = fileparts(str_);
x = convertCharsToStrings(x);
try
    % preserve representations of trailing floating-point
    if ~isempty(str2num(x)) %#ok<ST2NM> 
        fpx = fp + x;
        fp = fpx;
        x = '';
    end
catch ME
    handwarning(ME)
end
if ischar(str) || iscellstr(str)
    [pth,fp,x] = convertStringsToChars(pth, fp, x);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/myfileparts.m] ======  

end

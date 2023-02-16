function txt = jsonwrite(str, fqfn)
%  Args:
%      str struct
%      fqfn text
%  Returns:
%      txt text


txt = jsonencode(str, PrettyPrint=true);
txt = strrep(txt, "%", "%%"); % single % interferes with fprintf()
txt = strrep(txt, "\u", ""); % \u interferes with fprintf()

fid = fopen(fqfn, 'w');
fprintf(fid, txt);
fclose(fid);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/jsonwrite.m] ======  

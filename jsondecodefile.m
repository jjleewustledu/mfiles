function json_struct_ = jsondecodefile(file_name_)
%% JSONDECODEFILE ~ jsondecode(fileread(file_name_)).
%  Ensures that file suffix is ".json".  If file exists, replaces all "\" with "/" in outputs.
%  Args:
%      file_name_ {mustBeText}
%  Returns:
%      json_struct_ struct
%
%  Created 11-Sep-2023 16:44:00 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.14.0.2337262 (R2023a) Update 5 for MACI64.  Copyright 2023 John J. Lee.

arguments
    file_name_ {mustBeText}
end
[pth,fp,x] = myfileparts(file_name_);
if ~strcmp(x, ".json")
    file_name_ = fullfile(pth, strcat(fp, ".json"));
end
if ~isfile(file_name_)
    json_struct_ = [];
    return
end

txt = fileread(file_name_);
txt = strrep(txt, "\", "/");
json_struct_ = jsondecode(txt);


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/jsondecodefile.m] ======  

function [x,tf] = asrowdirs(x)
%% ASROWDIRS removes trailing filesep for cell-arrays of char/string; use with glob
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.6.0.1135713 (R2019a) Update 3.  Copyright 2019 John Joowon Lee. 

[x,tf] = asrow(x);
if ~iscell(x) || isempty(x)
    return
end
if ~ischar(x{1})
    return
end
y = cell(size(x));
for i = 1:length(x)
    if strcmp(x{i}(end), filesep)
        y{i} = x{i}(1:end-1);
    else
        y{i} = x{i};
    end        
end
x = y;

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/asrowdirs.m] ======  

function tf = isscalartext(txt)
%% ISSCALARTEXT generalizes isscalar() to understand strings and chars.
%  Args:
%      txt {mustBeText}
%  Returns:
%      tf -> true for scalar string objects (just like isscalar)
%      tf -> true for char arrays that aren't cells (like 'for_example')
%      tf -> false for cell arrays of strings (like {'a', 'b'})
%
%  Created 14-May-2025 12:11:05 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 24.2.0.2923080 (R2024b) Update 6 for MACA64.  Copyright 2025 John J. Lee.

if isstring(txt)
    % For string objects, use the same behavior as isscalar
    tf = isscalar(txt);
elseif ischar(txt)
    % For character arrays, return true
    tf = true;
elseif iscell(txt)
    % For cell arrays, return false
    tf = false;
else
    % For other types, apply isscalar
    tf = isscalar(txt);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/isscalartext.m] ======  

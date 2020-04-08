function tf = isnice(arr)
%% ISNICE tests for simple niceties:  ~isempty, ~isnan, ~isinf, isfinite; ~isnat.
%  @param arr is numeric, datetime, logical (returned without mod).
%  @returns tf is logical array.
%  Usage:  obj = isnice(obj) 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1296695 (R2019b) Update 4.  Copyright 2020 John Joowon Lee. 

if islogical(arr)
    tf = arr;
    return
end
if ~isnumeric(arr) && ~isdatetime(arr)
    error('mfiles:NotImplementedError', 'isnice does not support class(arr)->%s', class(arr))
end
if isempty(arr)
    tf = false;
    return
end
if isdatetime(arr)
    tf = ~isnat(arr);
    return
end

tf = ~isempty(arr);
tf = tf & ~isnan(arr);
tf = tf & ~isinf(arr);
tf = tf &  isfinite(arr);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/isnice.m] ======  

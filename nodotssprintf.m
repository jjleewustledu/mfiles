function s = nodotssprintf(varargin)
%  @param  varargin is compatible with sprintf.
%  @return s is char; all '*', '[', ']', ' ' removed; and all '<', '>', '(', ')', ':', '.' replaced with '_'.
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2018 John Joowon Lee. 

s = safesprintf(varargin{:});
s = strrep(s, '.', '_');




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/safesprintf.m] ======  

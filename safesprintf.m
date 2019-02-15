function s = safesprintf(varargin)
%  @param  varargin is compatible with sprintf.
%  @return s is char; all '*', '[', ']', ' ' removed; and all '<', '>', '(', ')', ':' replaced with '_'.
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2018 John Joowon Lee. 

s = sprintf(varargin{:});
s = strrep(s, '*', '');
s = strrep(s, '<', '_');
s = strrep(s, '>', '_');
s = strrep(s, '[', '');
s = strrep(s, ']', '');
s = strrep(s, '(', '_');
s = strrep(s, ')', '_');
s = strrep(s, ' ', '');
s = strrep(s, ':', '_');







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/safesprintf.m] ======  

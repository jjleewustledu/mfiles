function str = appendDatestr(str)
%% APPENDDATESTR appends date, time in a format suitable for filenames: e.g., '_2014Nov21_1159'.
%  Usage:  string = appendDatestr(string) 

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

str = [str '_' datestr(now, 'yyyymmmdd_HHMM')];








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/appendDatestr.m] ======  

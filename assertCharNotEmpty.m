function assertCharNotEmpty(s)
%% ASSERTCHARNOTEMPTY ... 
%  Usage:  assertCharNotEmpty(string) 
%          ^ throws exception if not char or if empty
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 

assert(ischar(s));
assert(~isempty(s));








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/assertCharNotEmpty.m] ======  

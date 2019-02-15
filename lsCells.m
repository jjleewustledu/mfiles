function lsCells(carr)
%% LSCELLS formats contents of cell-array of strings to be readable in the cmd window
%   
%  Usage:  lsCells(carr) 
%                  ^ cell-array of strings
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.12.0.62 (R2011a) 
%% $Id$ 

for c = 1:numel(carr) %#ok<*FORPF>
    fprintf('%s\n', carr{c});
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/lsCells.m] ======  

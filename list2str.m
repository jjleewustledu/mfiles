function str = list2str(alist, varargin)
%% LIST2STR ... 
%  Usage:  string = list2str(list_object[, param, value, ...]) 
%                            ^ List children
%                                          ^ param values for cell2str
%  Uses:   cell2str, mlpatterns.List

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

assert(isa(alist, 'mlpatterns.List'));
cellobj = cell(1, length(alist));
for a = 1:length(alist)
    cellobj{a} = alist.get(a);
end
str = cell2str(cellobj, varargin{:});






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/list2str.m] ======  

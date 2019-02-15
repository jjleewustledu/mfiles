function assertExistDir(fhandle, fname)
%% ASSERTEXISTDIR ... 
%  Usage:  assertExistDir(function_handle, filename) 
%                         ^ calling method must pass a handle to itself

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

assert(isa(fhandle, 'function_handle'), 'ASSERTEXISTDIR:  first parameter must be a function_handle');
assert(ischar(fname),                   'ASSERTEXISTDIR:  second parameter must be a filename string');
assert(lexist(fname, 'dir'), ...
       sprintf('%s could not find directory %s\n', upper(func2str(fhandle)), fname));








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/assertExistFile.m] ======  

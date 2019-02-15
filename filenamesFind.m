function fqfns = filenamesFind(pth, patt, fhandles)
%% FINDFILENAMES searches for relevant files in the specified path; applies selection-rules
%  Usage:  filenames = this.findFilenames(path, pattern, selection_rules)
%          ^ cell-array                   ^     ^ strings
%                                                        ^ function handles or cell-array of   
%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/filenamesFind.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

assert(lexist(pth, 'dir'));
assert(ischar(patt));
dt    = mlsystem.DirTool(fullfile(pth, patt));
fqfns = dt.fqfns;

if (exist('fhandles','var'))
    if (~iscell(fhandles)); fhandles = {fhandles}; end
    for h = 1:length(fhandles)
        assert(isa(fhandles{h}, 'function_handle'));
        fqfns = fhandles{h}(fqfns);
    end
end





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/findFilenames.m] ======  

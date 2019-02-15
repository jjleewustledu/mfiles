function [p,f,e] = pathparts(fqfn, depth, forcepth)
%% PATHPARTS adds additional functionality to fileparts 
%   
%  Usage:  [p,f,e] = pathparts(fqfn[, depth, forcepth]) 
%           ^                  ^ strings, same as for fileparts
%                                fqfn may be a cell-array; then p,f,e will be cell-arrays
%                                                                 
%                                    ^ int; default 0 returns exactly the results of fileparts
%                                      for fqfn = /p3/p2/p1/f.e, depth 0 returns p=/p3/p2/p1
%                                                                depth 1 returns p=p1, depth 2 returns p=p2, ...
%                                                                 
%                                      for fqfn = /p3/p2/p1/,    depth 0 returns p='',
%                                                                depth 1 returns p=p1, depth 2 returns p=p2, ...
%                                                                 
%                                      for fqfn = /p3/p2/p1,     depth 0 returns p=/p3/p2, f=p1, e=''
%                                                                depth 1 returns p=p2, depth 2 returns p=p3, ...
%                                                                 
%                                             ^ logical, default false
%                                               when true, forces fqfn to end with filesep
%                                               /p3/p2/p1/f.e -> /p3/p3/p1/f.e/
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $  
%% and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/pathparts.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 

assert(isunix, 'mfiles:UnsupportedMachineType');
if (~exist('depth','var'));    depth = 0; end
if (~exist('forcepth','var')); forcepth = false; end

if (forcepth)
    if (~strcmp(filesep, fqfn(end)))
        fqfn = [fqfn filesep];
    end
end
if (iscell(fqfn))
    
    p = cell(size(fqfn));
    f = cell(size(fqfn));
    e = cell(size(fqfn));
    for c = 1:numel(fqfn) %#ok<FORPF>
        [p{c},f{c},e{c}] = pathparts(fqfn{c}, depth); %% recursion
    end
else
    
    [p,f,e] = fileparts(fqfn);
    if (isempty(p)); return; end
    if (depth > 0)
        
        if (strcmp(p(1),'/'));         p = p(2:end); end 
        flds = regexp(p, '/', 'split');
        if (depth > length(flds)); depth = length(flds); end
        p = flds{length(flds) - depth + 1};
    end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/from_pth.m] ======  

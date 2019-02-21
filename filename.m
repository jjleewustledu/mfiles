function fn = filename(filobj, ext)
%% FILENAME converts a fileprefix or INIfTI to a filename with filetype extension or cells thereof
%  Usage:  fname = filename(filobj[, ext]) 
%                           ^ char or NIfTI, but not cells
%                             understands '*' and '?'
%                                     ^ explicit file extension
%          ^ char or cells
%  Requires:  dir2cell, fileprefix
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

    import mlfsl.* mlfourd.*;
    if (iscell(filobj) && 1 == numel(filobj)); filobj = filobj{1}; end
    if (~exist('ext','var')); ext = NIfTIInfo.FILETYPE_EXT; end
    
    % cell arrays
    assert(~iscell(filobj), 'filename does not support cell-arrays; use filenames');
    
    % wildcards
    if (ischar(filobj) && ...
        (lstrfind(filobj,'?') || lstrfind(filobj,'*'))) 

        filecells = dir2cell(filobj);
        fn        = cell(size(filecells));
        for f     = 1:length(fn) %#ok<FORPF>
            fn{f} = filename(filecells{f}, ext);
        end
    else

        % business
        if (      isa(filobj, 'mlfourd.INIfTI') || ...
            (isstruct(filobj) && isfield(filobj, 'fileprefix')))
        
            filestr = filobj.fileprefix;
            fn      = [fileprefix(filestr,ext) ext];
        elseif (ischar(filobj))
            fn      = [fileprefix(filobj,ext) ext];
        else
            error('mfiles:UnsupportedType', ...
                'mfiles.filename does not support filobj of type->%s', class(filobj));
        end
    end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/filename.m] ======  

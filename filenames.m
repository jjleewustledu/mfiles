function fns = filenames(filobj, ext, rtncell)
%% FILENAMES converts a fileprefix, NIfTI or cell-array to a filename(s) with specified filetype extension;
%            default extension is NIfTId.FILETYPE_EXT
%  Usage:  fnames = filenames(filobj[, ext, rtncell]) 
%                             ^ fileprefix string, NIfTI or cells of
%                               understands '*' and '?'
%                                      ^ char extension to use
%                                           ^ bool:  force return of cell-array
%          ^ cells of char with extension ext or default
%  Requires:  fileprefixes, filename
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

    import mlfsl.* mlfourd.*;
	if (isempty(filobj));          fns     = filobj; return; end
    if (~exist('ext','var'));      ext     = NIfTId.FILETYPE_EXT; end
    if (~exist('rtncell', 'var')); rtncell = false; end

    if (iscell(filobj))

        fns   = fileprefixes(filobj, ext, true); 
        for f = 1:length(fns) %#ok<FORPF>
            fns{f} = [fns{f} ext];
        end
    else
        
        fns = filename(filobj, ext);
    end

    if (rtncell && ~iscell(fns)); fns = {fns}; end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/filename.m] ======  

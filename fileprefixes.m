function fps = fileprefixes(filobj, ext, rtncell)
%% FILEPREFIX converts filenames or NIfTI to fileprefixes w/o extensions
%             accepts cell-arrays as input; similar to basename in bash
%             always returns cell-array
%  Usage:  fprefixes = fileprefixes(filobj[, ext, rtncell]) 
%                                   ^ char, NIfTI or cells of
%                                     understands '*' and '?'
%                                            ^ char extension
%                                                 ^ bool:  true forces return of cell-array
%          ^ cell-array
%  Requires:  fileprefix
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

    import mlfsl.* mlfourd.*;
	if (isempty(filobj));          fps     = filobj; return; end
    if (~exist('ext',     'var')); ext     = NIfTIInfo.FILETYPE_EXT; end
    if (~exist('rtncell', 'var')); rtncell = false; end
    
    
    if (~iscell(filobj))
        
        fps = fileprefix(filobj, ext);
    else
    
        if (numel(filobj) == 1)
            fps = fileprefix(filobj{1}, ext);
        else
            
            fps = cell(size(filobj));
            for f = 1:numel(filobj) %#ok<FORPF>
                fps{f} = fileprefixes(filobj{f}, ext, rtncell);
            end
            fps = squeezeCell(fps);
        end
    end
    
    

        
 
    
    
    % force returned object to be cell
    if (rtncell && ~iscell(fps)); fps = {fps}; end




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/fileprefix.m] ======  

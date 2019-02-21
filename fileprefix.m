function fp = fileprefix(filobj, ext)
%% FILEPREFIX converts filenames or NIfTI w/ specified extension to a fileprefix w/o extension
%             similar to basename in bash
%  Usage:  fprefix = fileprefix(filobj[, ext]) 
%                               ^ char or NIfTI, but not cells
%                                 understands '*' and '?'
%                                        ^ char extension
%          ^ char or cells
%  Requires:   dir2cell
%  Restrictions:  no parfor
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

    import mlfsl.* mlfourd.*; %#ok<*NSTIMP>
	if (isempty(filobj));                          fp  = filobj; return; end
    if (iscell( filobj) && 1 == numel(filobj)); filobj = filobj{1}; end
    if (~exist('ext', 'var'));                     ext = NIfTIInfo.FILETYPE_EXT; end
    
    % non-trivial cell arrays
    assert(~iscell(filobj), 'fileprefix does not support cell-arrays; use fileprefixes');

    % wildcards
    if (ischar(filobj) && ...
        (lstrfind(filobj,'?') || lstrfind(filobj,'*'))) 
   
        filecells = dir2cell(filobj);
        fp        = {[]};
        f1        = 1;
        for f     = 1:length(filecells) %#ok<*FORFLG,*PFUNK>
            if (lstrfind(   filecells{f}, ext))
                fp{f1} = fileprefix(filecells{f}, ext); %#ok<*PFPIE>
                f1     = f1 + 1;
            end
        end
    else

        % business
        if (isa(      filobj, 'mlfourd.INIfTI') || ...
            (isstruct(filobj) && isfield(filobj, 'fileprefix')))
        
            filestr = filobj.fileprefix;
            fp      = rmext(filestr, ext);
        elseif (ischar(filobj))
            fp      = rmext(filobj, ext);
        else
            throw(MException('mfiles:UnsupportedType', ...
                  sprintf('fcn fileprefix does not support filobj of type->%s\n', class(filobj))));
        end
    end
    
    

    function fp1 = rmext(filestr1, ext1)
        
        %% INTERNAL RMEXT
        %  Usage:  strout = rmext(strin, torm)
        ptr = strfind(filestr1, ext1);
        if (~isempty(ptr))
            for p = length(ptr):-1:1
                if (ptr(p)+length(ext1) < length(filestr1))
                    morestr = filestr1(ptr(p)+length(ext1):end);
                else
                    morestr = '';
                end
                filestr1 = [filestr1(1:ptr(p)-1) morestr];
            end
        end    
        fp1 = filestr1;
    end % rmext
end % fileprefix






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/fileprefix.m] ======  

function str = cell2str(c, varargin)
    %% CELL2STR converts cell-arrays of char, double, structs to a single string suitable for use with fprintf, sprintf;
    %  elements of cell-array must have same type
    %  Usage:  string = cell2str(cellarr[, param, value, param2, value2, ...])
    %                                      ^ AsRow       logical
    %                                      ^ WithQuotes  logical
    %                                      ^ IgnoreEmpty logical
    %  Test:  ial = mlfourd.ImagingArrayList; ial.add(NIfTI.load('t1_default')); ial.add(NIfTI.load('t2_default')); 
    %         cell2str({[1 2 3; 4 5 6] [4 6] [] 7 'this is char' struct('fieldone',1,'fieldtwo',{8 9 struct('field3', 3, 'field4', 'last')}) ial})    
    %  ans =
    %  [1 2 3;4 5 6]
    %  [4 6]
    %  []
    %  7
    %  this is char
    %  fieldone: 1; fieldtwo: 8; 
    %  fieldone: 1; fieldtwo: 9; 
    %  fieldone: 1; fieldtwo: field3: 3; field4: last;;
    %  /Volumes/InnominateHD3/Local/test/cvl/np755/mm01-020_p7377_2009feb5/fsl/t1_default.nii.gz
    %  /Volumes/InnominateHD3/Local/test/cvl/np755/mm01-020_p7377_2009feb5/fsl/t2_default.nii.gz
    %  See also:  mlpatterns.List, list2str, struct2str, func2str, num2str, ensureString

    %% Version $Revision$ was created $Date$ by $Author$,
    %% last modified $LastChangedDate$ and checked into svn repository $URL$
    %% Developed on Matlab 7.12.0.635 (R2011a)
    %% $Id$

    ip = inputParser;
    ip.KeepUnmatched = true;
    addRequired( ip, 'c',                  @iscell);
    addParameter(ip, 'AsRow',       true, @islogical);
    addParameter(ip, 'IgnoreEmpty', false, @islogical);
    addParameter(ip, 'WithQuotes',  false, @islogical);
    parse(ip, c, varargin{:});

    if (ip.Results.AsRow)
        if (ip.Results.WithQuotes)
            frmt = '%s ''%s''';
        else
            frmt = '%s %s';
        end
    else
        if (ip.Results.WithQuotes)
            frmt = '%s\n''%s''';
        else
            frmt = '%s\n%s';
        end
    end

    str = '';
    for ic = 1:numel(c) %#ok<*FORFLG>
        cval = c{ic};
        switch (class(cval))
            case 'cell'
                str = appendEntry(str, cell2str(cval, varargin{:}));
            case 'struct'
                str = appendEntry(str, struct2str(cval, varargin{:}));
            case 'char'
                str = appendEntry(str, cval);
            case 'function_handle'
                str = appendEntry(str, func2str(cval));
            case 'logical'
                if (cval)
                    cval = 'true';
                else
                    cval = 'false';
                end
                str = appendEntry(str, cval);
            otherwise
                try
                    if (isa(cval, 'mlpatterns.List'))
                        str = appendEntry(str, list2str(cval, varargin{:}));
                    elseif (isempty(cval))
                        if (~ip.Results.IgnoreEmpty)
                            str = appendEntry(str, '[]');
                        end
                    elseif (isnumeric(cval))
                        str = appendEntry(str, mat2str(cval));
                    else
                        str = appendEntry(str, char(cval));
                    end
                catch ME
                    str = appendEntry(str, [' UnsupportedType:' class(cval)]);
                    handwarning(ME);
                end
        end
    end
    str = strtrim(str);
    
    function str_ = appendEntry(str_, val_)
        str_ = sprintf(frmt, str_, val_);
    end
end





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/cell2str.m] ======  

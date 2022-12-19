function str = struct2str(aStruct, varargin)
    %% STRUCT2STR
    %  Usage:  string = struct2str(aStruct[, param, value]) 
    %                                        ^ 'Punctuation', default true
    %                                        ^ 'Assignment', default ': '
    %                                        ^ 'Separator', default ', '
    %                                        ^ 'JsonEncode', default false
    %                                        ^ 'ConvertInfAndNan', default true
    %                                        ^ 'PrettyPrint', default false
    %  test:  struct2str(struct('single_field', struct('fieldone',1,'fieldtwo',[2 3; 4 5], 'fieldthree', struct("fieldfour", "lastitem"))))
    %  ans:   'single_field:fieldone:1,fieldtwo:[2 3;4 5],fieldthree:fieldfour:lastitem,,,'
    %  test:  struct2str(struct('single_field', struct('fieldone',1,'fieldtwo',[2 3; 4 5], 'fieldthree', struct("fieldfour", "lastitem"))), Punctuation=false)
    %  ans:   'single_field fieldone 1 fieldtwo [2 3;4 5] fieldthree fieldfour lastitem '
    %  test:  struct2str(struct('single_field', struct('fieldone',1,'fieldtwo',[2 3; 4 5], 'fieldthree', struct("fieldfour", "lastitem"))), JsonEncode=true)
    %  ans:   '{"single_field":{"fieldone":1,"fieldtwo":[[2,3],[4,5]],"fieldthree":{"fieldfour":"lastitem"}}}'
    %  test:  struct2str(struct('single_field', struct('fieldone',1,'fieldtwo',[2 3; 4 5], 'fieldthree', struct("fieldfour", "lastitem"))), JsonEncode=true, PrettyPrint=true)
    %  ans:   '{
    %            "single_field": {
    %              "fieldone": 1,
    %              "fieldtwo": [
    %                [
    %                  2,
    %                  3
    %                ],
    %                [
    %                  4,
    %                  5
    %                ]
    %              ],
    %              "fieldthree": {
    %                "fieldfour": "lastitem"
    %              }
    %            }
    %          }'
    %  See also:  cell2str, list2str, func2str, num2str, ensureString

    %% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
    %% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/struct2str.m $ 
    %% Developed on Matlab 7.13.0.564 (R2011b) 
    %% $Id$ 

    ip = inputParser;
    ip.KeepUnmatched = true;
    addRequired( ip, 'aStruct', @isstruct);
    addParameter(ip, 'Punctuation', true, @islogical);
    addParameter(ip, 'Assignment', ': ', @istext);
    addParameter(ip, 'Separator', ', ', @istext);
    addParameter(ip, 'JsonEncode', false, @islogical);
    addParameter(ip, 'ConvertInfAndNaN', true, @islogical);
    addParameter(ip, 'PrettyPrint', false, @islogical);
    parse(ip, aStruct, varargin{:});
    ipr = ip.Results;
    if ~ipr.Punctuation   
        ipr.Assignment = ' ';
        ipr.Separator = ' ';
    end
    if ipr.JsonEncode
        str = jsonencode(aStruct, ConvertInfAndNaN=ipr.ConvertInfAndNaN, PrettyPrint=ipr.PrettyPrint);
        return
    end

    str  = '';
    flds = fields(aStruct);
    for s = 1:length(aStruct)
        for f = 1:length(flds) %#ok<*FORFLG,*PFUNK>
            fldval = aStruct(s).(flds{f});
            switch (class(fldval))
                case 'cell'
                    str = appendEntry(str, flds{f}, cell2str(fldval, varargin{:}));
                case 'struct'
                    str = appendEntry(str, flds{f}, struct2str(fldval, varargin{:}));
                case 'char'
                    str = appendEntry(str, flds{f}, fldval);
                case 'function_handle'
                    str = appendEntry(str, flds{f}, func2str(fldval));
                case 'logical'
                    if (fldval)
                        fldval = 'true';
                    else
                        fldval = 'false';
                    end
                    str = appendEntry(str, flds{f}, fldval);
                otherwise
                    try
                        if (isa(fldval, 'mlpatterns.List'))
                            str = appendEntry(str, flds{f}, list2str(fldval, varargin{:})); 
                        elseif (isempty(fldval))                            
                            str = appendEntry(str, flds{f}, '[]');
                        elseif (isnumeric(fldval))
                            str = appendEntry(str, flds{f}, mat2str(fldval));
                        else
                            str = appendEntry(str, flds{f}, char(fldval));
                        end
                    catch ME
                        str = appendEntry(str, flds{f}, [' UnsupportedType:' class(fldval)]);
                        handexcept(ME);
                    end
            end
        end
    end

    function str_ = appendEntry(str_, fld_, fldval_)
        try
            str_ = [str_ fld_ ipr.Assignment strtrim(fldval_) ipr.Separator]; %#ok<*AGROW>
        catch
            str_ = append(str_, fld_, ipr.Assignment, strtrim(fldval_), ipr.Separator); %#ok<*AGROW>
        end
    end
end



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/struct2str.m] ======  

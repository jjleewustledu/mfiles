%CHECKFIELD Check validity of structure field contents.
%
%   CHECKFIELD intend to be a facility to handle varargin in functions. It
%   provides error checks, default, and structuring the varargin.
%
%   k = CHECKFIELD(field,listfield) where field is a string checks if field is
%   one of the fields in the cell listfield given in second argument. It
%   returns the index of the found field in the list if successful.
%
%   K = CHECKFIELD(argin,listfield) where argin is a cell of paired arguments,
%   e. g., {'intfield', 37, 'floatfield', 3.1, 'charfield', 'itsvalue'},
%   first checks if argin has field/value pairs, and then if the fields are in the
%   cell listfield given in second argument. It returns the array of index
%   of the fields in the list if successful.
%
%   S = CHECKFIELD(field,value,TESTVALID) checks the contents of the specified
%   value to be valid for the field 'field', by applying it to the
%   function handle TESTVALID, which must be a function that returns a
%   boolean.
%
%   S = CHECKFIELD(field,value,TESTVALID,ACCEPTABLEVALUES) also checks the
%   contents of the specified value to be within a cell array given by
%   ACCEPTABLEVALUES, but value and ACCEPTABLEVALUES must be char.  
%
%   S = CHECKFIELD(argin,listfield,...) where all of these arguments are
%   cells (including TESTVALID, ACCEPTABLEVALUES), does all these tests for 
%   each pair field/value.  argin does not need to have char.
%
%   The last three syntaxes return a struct for which there is field to match
%   the passed field.  The values are checked with TESTVALID or ACCEPTABLEVALUES 
%   as specified.
%
%   S = CHECKFIELD(argin,listfield,...,S) does the same, but updates
%   the previous fields of S (which can be e.g. defaults) with the new
%   values checked.
%
%   All values can be cell array. In this case, the testvalid is applied to
%   each cell element, and the corresponding field in the returned struct
%   is a cell.
%
%   EXAMPLE:
%   Suppose you are writing a m-file that would take variable argument
%   number (varargin):
% ------------------------------------
% function M = getimagenames(varargin)
%
% listfields = { ...
%     'Method',...
%     'First' };
%
% testvalid = { ...
%     @ischar, ...
%     @(i) iswhole(i) & i>0 };
%
% acceptablevalues = {
%     accimagetype, ...
%     {'Range', 'All', 'Index'}, ...
%     {} };
%
% default = struct( ...
%     'method','all', ...
%     'first',1);
%
% S = checkfield(varargin,listfields,testvalid,acceptablevalues,default);
% ------------------------------------
%
%   S is now a struct with field 'method' and 'first' whose value are
%   default unless the user entered new values for them, such as with
%       getimagenames('extension','tif')
%
%   See also: VARARGIN

% ------------------ INFO ------------------
%   Author: Jean-Yves Tinevez
%   Work address: Max-Plank Insitute for Cell Biology and Genetics,
%   Dresden,  Germany.
%   Email: tinevez AT mpi-cbg DOT de
%   November 2008;
%   Permission is given to distribute and modify this file as long as this
%   notice remains in it. Permission is also given to write to the author
%   for any suggestion, comment, modification or usage.
% ------------------ BEGIN CODE ------------------

function varargout = checkfield(varargin)

stack = dbstack;
if length(stack) > 1
    callername = '';
    i = 0;
    while ~strcmpi(callername,'checkfield')
        i = i + 1;
        callername = stack(i).name;
    end
else
    callername = 'workspace';
end

%% Only check if the fields are known.
if nargin == 2

    field = varargin{1};
    listfield = varargin{2};
    % Check if field is within a given list
    if iscell(field)
        n = length(field);
        if mod(n,2) ~= 0
            errid = ['MATLAB:', callername,':BadFieldNumber'];
            errmsg = 'Field/Value must come by pair, found %s.';
            error(errid,errmsg,num2str(n));
        end
        index = zeros(n/2,1);
        for i = 1:n/2
            index(i) = checkfield(field{2*i-1},listfield);
        end
        varargout{1} = index; % returns the index of fields in the field list
    else
        lowerlist = lower(listfield);
        lowerfield = lower(field);
        k = strmatch(lowerfield,lowerlist,'exact');
        knownfield = ~isempty(k);
        if ~knownfield
            strfield = '';
            for i=1:length(listfield)
                strfield = [strfield,' ',listfield{i}]; %#ok<AGROW>
            end
            errid = ['MATLAB:', callername,':UnknownField'];
            errmsg = ['Field ''%s'' is unknown, must be one of:\n',strfield];
            error(errid,errmsg,field);
        end
        varargout{1} = k; % returns the index of this field in the field list
    end

    %% Also check if their values are correct
elseif nargin >= 3

    field = varargin{1};

    if iscell(field)

        S = struct();
        listfield = varargin{2};
        testvalid = varargin{3};
        if nargin >= 4
            default = [];
            if isstruct(varargin{4})
                default = varargin{4}; % last one is the default, not the acceptable cell
                acceptablevalues = cell(length(listfield),1); % empty cell -> will be accepted
            else
                acceptablevalues = varargin{4};
                if nargin == 5
                    default = varargin{5}; % last one is the default
                end
            end

            if ~isempty(default)
                defaultfield = fieldnames(default);
                defaultvalue = struct2cell(default);
                n = length(defaultfield);
                lowerlist = lower(listfield);
                for i = 1:n,
                    lowerfield = lower(defaultfield{i});
                    defaultindex = strmatch(lowerfield,lowerlist);
                    if ~isempty(defaultindex)
                        fieldname = listfield{defaultindex}; % We use the listfield value for name, so that there is the proper capitalization of field names.
                    else
                        % No matching item in the field list, so we use the
                        % default name
                        fieldname = defaultfield{i};
                    end
                    S.(fieldname) = defaultvalue{i};
                end

            end

        else
            % no default, no acceptable cell
            acceptablevalues = cell(length(listfield),1); % empty cell -> will be accepted
        end

        index = checkfield(field,listfield); % check if all fields are in the list
        n = length(field);
        for i = 1:n/2;
            j = 2 * i -1;
            fieldid = field{j};
            value = field{j+1};
            checkfield(fieldid,value,testvalid{index(i)},acceptablevalues{index(i)});
            fieldname = listfield{ index(i) }; % We use the listfield value for name, so that there is the proper capitalization of field names.
            S.(fieldname) = value;
        end
        varargout{1} = S;

    else

        value = varargin{2};
        % empty matrix is always valid
        if isempty(value)
            return
        end

        testvalid = varargin{3};
        S = struct();

        if nargin >= 4
            if isstruct(varargin{4})
                S = varargin{4}; % last one is the default, not the acceptable cell
                acceptablevalues = cell(length(field),1); % empty cell -> will be accepted
            else
                acceptablevalues = varargin{4};
                if nargin == 5
                    S = varargin{5}; % last one is the default
                end
            end

        else
            % no default, no acceptable cell
            acceptablevalues = [];% cell(length(field),1); % empty cell -> will be accepted
        end
       
       
        if ~iscell(value)
            nval = {value};
        else
            nval = value;
        end
       
        for i = 1 : length(nval)
            if ~testvalid(nval{i})
                errid = ['MATLAB:', callername,':BadParameterType'];
                errmsg = ['Value for parameter ''%s'' must give a true result when cast upon ''',func2str(testvalid),'''.'];
                error(errid,errmsg,field);
            end

            % empty acceptable values means accept all
            if ~isempty(acceptablevalues)
                try
                    % Cell of strings
                    loweracc = lower(acceptablevalues);
                    if isnumeric(nval{i}); nval{i} = num2str(nval{i}); end
                    lowervalue = lower(nval{i});
                    k = strmatch(lowervalue,loweracc,'exact');  
                catch ME %#ok<NASGU>
                    % Cell or Array of numbers                   
                    if iscell(acceptablevalues)
                        loweracc = cell2mat(acceptablevalues);
                    else
                        loweracc = acceptablevalues;
                    end
                    lowerval = nval{i};
                    k = find( loweracc == lowerval );
                end

                wasacceptable = ~isempty(k);

                if ~wasacceptable
                    stracc = '';
                    for j=1:length(acceptablevalues)
                        if iscell(acceptablevalues)
                            stracc = [stracc,' ',acceptablevalues{j}]; %#ok<AGROW>
                        else
                            stracc = [stracc,' ',acceptablevalues]; %#ok<AGROW>
                        end
                    end
                    errid = ['MATLAB:', callername,':BadParameterType'];
                    errmsg = ['Value for parameter ''%s'' must be one of:\n',stracc];
                    error(errid,errmsg,field);
                end % end if ~was
            end % end if ~isempty
        end % end for

        S.(field) = value;
        varargout{1} = S;

    end
end % if nargin == 2

end % main function


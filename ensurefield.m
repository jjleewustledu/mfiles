function obj1 = ensurefield(obj, field, test, acceptablevalues, default)
%% ENSUREFIELD ... 
%   
%  Usage:  obj = ensurefield(obj, field, [test, acceptablevalues, default]) 
%                            ^ struct, object to contain the field
%                                 ^ field names, strings 
%                                   if field is missing, it gets added with 0 or default
%                                         ^ tests that return bool, e.g., @ischar 
%                                               ^ must match type of field contents (may be cell array)
%                                                 {} accepts all values
%
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.10.0.499 (R2010a) 
%% $Id$ 
   
    assert(nargin > 0);
    obj1 = obj;
    switch (nargin)
        case 2
            obj1 = withfield(obj1, field);
        case 3
            % *also* ensure that the value of obj1.(field) passes test
            try
                S = checkfield({field, obj1.(field)}, fieldnames(obj1), dealtest(obj1, test));
                obj1.(field) = S.(field);
            catch ME %#ok<*MUCTH>
                handexcept(ME, 'nargin->3');
            end
        case 4
            % *also* ensure that the value of obj1.(field) falls within acceptablevalues
            try
                S = checkfield({field, obj1.(field)}, fieldnames(obj1), ...
                                dealtest(obj1, test), dealacceptable(obj1, acceptablevalues));
                obj1.(field) = S.(field);
            catch ME
                handexcept(ME, 'nargin->4')
            end
        case 5
            % *also* insert default values as needed
            try
                S0 = struct(field, default);
                S  = checkfield({field, obj1.(field)}, fieldnames(obj1), ...
                                 dealtest(obj1, test), dealacceptable(obj1, acceptablevalues), S0);
                obj1.(field) = S.(field);
            catch ME
                % use default value in case of errors
                %warning('mfile:CaughtException',     'MException REPORT: =============================================\n');
                %disp(getReport(ME));
                if (isnumeric(default))
                    msg = 'setting %s -> %g';
                else
                    msg = 'setting %s -> %s';
                end
                if (~ischar(default))
                    dproxy = ['default value has class ' class(default)];
                else
                    dproxy = default;
                end
                %warning('mfiles:UsingDefaultValues', msg, field, dproxy);
                %disp('==========================================================================');
                obj1.(field) = default;
            end
            
        otherwise
            error('mfiles:NotImplemented', ['ensurefield.nargin->' num2str(nargin)]);
    end
    
            
            
    
    function obj1 = withfield(obj, field)
        %% WITHFIELD ensures that obj has field, otherwise field is created with initial value 0
        obj1 = obj;
        if (isempty(obj)); obj1 = struct; return; end
        if (~lstrfind(fieldnames(obj), field))
            obj1 = obj;
            obj1.(field) = 0;
        end
    end

    function tests = dealtest(obj, test)
        %% DEALTEST deals the test over a cell-array that has size matched to fieldnames of obj
        tests = cell(1,length(fieldnames(obj)));
        [tests{:}] = deal(test);
    end

    function vals = dealacceptable(obj, val)
        %% DEALACCEPTABLE deals val over a cell-array that has size matched to fieldnames of obj
        if (~iscell(val)); val = {val}; end
        for v = 1:length(val)
            val{v} = aschar(val{v}); 
        end
        vals = cell(1,length(fieldnames(obj)));
        [vals{:}] = deal(val);
    end

    function obj1 = aschar(obj)
        assert(~isempty(obj));
        obj1 = obj;
        switch (class(obj))
            case 'struct'
                obj1 = struct2cell(obj1);
            case 'cell'
                tmp = '';
                for n = 1:length(obj1)
                    tmp = [tmp ' ' aschar(obj1{n})]; %#ok<AGROW>
                end
                obj1 = strtrim(tmp);
            case 'char' % do nothing
            otherwise
                if (isnumeric(obj1) || isa(obj1, 'dip_image'))
                    obj1 = num2str(double(obj1));
                else
                    error('mfiles:NotImplemented', ['ensurefield.aschar.class(obj1)->' class(obj1)]);
                end
        end
        assert(ischar(obj1));
    end
end
% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mfiles/ensurefield.m] ======  

function txt = jsonrecode(dataOri, dataNew, varargin)
    %% JSONRECODE adds additional information to existing json data objects.
    %  Args:
    %      dataOri (required []|file|text|struct): original json data in file, text or struct.
    %      dataNew (required []|file|text|struct): new json data in file, text or struct.
    %      PrettyPrint (logical): default is true.  See also web(fullfile(docroot, 'matlab/ref/jsonencode.html#namevaluepairarguments')).
    %      filenameNew (text): new json filename to write.  By default writes nothing. 
    %      noclobber (logical): default is false.
    %  Returns:
    %      txt: generated by jsonencode.
    %
    %  Created 02-Jan-2022 17:06:59 by jjlee in repository
    %  /Users/jjlee/MATLAB-Drive/mfiles.
    %  Developed on Matlab 9.11.0.1809720 (R2021b) Update 1 for MACI64.  Copyright 2022 John J. Lee.
    
    ip = inputParser;
    addRequired(ip, 'dataOri', @(x) isempty(x) || isstruct(x) || istext(x) || isa(x, 'mlio.IOInterface'))
    addRequired(ip, 'dataNew', @(x) isempty(x) || isstruct(x) || istext(x) || isa(x, 'mlio.IOInterface'))
    addParameter(ip, 'PrettyPrint', true, @islogical)
    addParameter(ip, 'filenameNew', '', @(x) istext(x) || isa(x, 'mlio.IOInterface'))
    addParameter(ip, 'noclobber', false, @islogical)
    parse(ip, dataOri, dataNew, varargin{:});
    ipr = ip.Results;
    if isa(ipr.filenameNew, 'mlio.IOInterface')
        ipr.filenameNew = ipr.filenameNew.fqfn;
    end
    ipr.filenameNew = ensureExt(ipr.filenameNew, '.json');
    
    % dataOri -> struct
    try
        if isa(dataOri, 'mlio.IOInterface')
            dataOri = fqfn2txt__(dataOri.fqfn);
        end
        if istext(dataOri)
            if ~any(contains(dataOri, "{")) && ~any(contains(dataOri, "}"))
                dataOri = fqfn2txt__(dataOri);
            end
            dataOri = jsondecode(dataOri);
        end
        assert(isstruct(dataOri))
    catch
        dataOri = struct( ...
            'Name', 'Unknown', ...
            'BIDSVersion', '1.7.0', ...
            'GeneratedBy', clientname(true, 2));
    end
    
    % dataNew -> struct
    try
        if isa(dataNew, 'mlio.IOInterface')
            dataNew = fqfn2txt__(dataNew.fqfn);
        end
        if istext(dataNew) 
            if ~any(contains(dataNew, "{")) && ~any(contains(dataNew, "}"))
                dataNew = fqfn2txt__(dataNew);
            end
            dataNew = jsondecode(dataNew);
        end
        assert(isstruct(dataNew))
    catch ME
        dataNew = struct('jsonrecode', ME.identifier);
    end
    
    % manage duplicates
    duplicates = intersect(fields(dataOri), fields(dataNew));
    if ~isempty(duplicates)
        for dupl = asrow(duplicates)
            field1 = dupl{1};
            while any(strcmp(field1, duplicates)) % search for unique field1
                field1 = strcat(field1, '_');
            end
            dataNew.(field1) = dataNew.(dupl{1});
            dataNew = rmfield(dataNew, dupl{1});
        end
    end

    % dataOri & dataNew -> txt
    txt = jsonencode__(mergeStruct(dataOri, dataNew), ipr.PrettyPrint);
    
    % write to filenameNew
    if isempty(ipr.filenameNew) 
        return
    end
    if isfile(ipr.filenameNew) && ipr.noclobber
        return
    end
    try
        fid = fopen(ipr.filenameNew, 'w');
        fprintf(fid, txt);
        fclose(fid);
    catch ME
        handwarning(ME)
        dataME = struct('jsonrecode', ME.identifier);
        txt = jsonencode__(mergeStruct(dataOri, dataME), ipr.PrettyPrint);

        fid = fopen(ipr.filenameNew, 'w');
        fprintf(fid, txt);
        fclose(fid);
    end

    %% INTERNAL
    
    function txt_ = fqfn2txt__(fqfn)
        fqfn = ensureExt(fqfn, '.json');
        if ~isfile(fqfn)
            txt_ = ['{"jsonrecode":"', fqfn, ' not found"}'];
            return
        end
        txt_ = fileread(fqfn);        
    end
    function txt_ = jsonencode__(dat_, prettyPrint)
        txt_ = jsonencode(dat_, 'PrettyPrint', prettyPrint);
        txt_ = strrep(txt_, "%", "%%"); % single % interferes with fprintf()
        txt_ = strrep(txt_, "\u", ""); % \u interferes with fprintf()
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/jsonrecode.m] ======  

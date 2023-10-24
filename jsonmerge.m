function j3 = jsonmerge(j1, j2, opts)
%% JSONMERGE merges json contents of j1 and j3, returning j3 cast as struct, writing to non-empty opts.filename.
%
%  Created 15-Oct-2023 23:12:53 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 23.2.0.2380103 (R2023b) Update 1 for MACI64.  Copyright 2023 John J. Lee.

arguments
    j1 {mustBeNonempty}
    j2 {mustBeNonempty}
    opts.filename {mustBeTextScalar} = ""
    opts.variable_names {mustBeText} = ["Var1", "Var2"]
end
vnames = convertCharsToStrings(opts.variable_names);

switch class(j1)
    case 'struct'
    case {'char', 'string'}
        if isfile(j1)
            j1 = readstruct(j1);
        else
            j1 = jsondecode(j1);
        end
    otherwise
end

switch class(j2)
    case 'struct'
    case {'char', 'string'}
        if isfile(j2)
            j2 = readstruct(j2);
        else
            j2 = jsondecode(j2);
        end
    otherwise
end

% ensure disjoint fields for j1 and j2 by migrating duplicates from j2 to j1
for fld = asrow(fields(j1))
    if contains(fld{1}, fields(j2))
        if strcmp(class(j1.(fld{1})), class(j2.(fld{1})))
            j1.(fld{1}) = {j1.(fld{1}), j2.(fld{1})};
        else
            j1.(fld{1}) = struct(vnames(1), j1.(fld{1}), vnames(2), j2.(fld{1}));
        end
        j2 = rmfield(j2, fld{1});
    end    
end

t1 = struct2table(j1);
t2 = struct2table(j2);
j3 = table2struct([t1, t2]);

if ~isemptytext(opts.filename)
    if ~endsWith(opts.filename, ".json")
        opts.filename = opts.filename + ".json";
    end
    writestruct(j3, opts.filename);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/jsonmerge.m] ======  

function obj = ensureNiiCell(obj)

%% ENSURENII returns NIfTI for any plausible string, numerical type, NIfTI subclass
%  Usage:  obj = ensureNiiCell(obj) 

if (iscell(obj))
    obj2  = cell(1,numel(obj));
    for o = 1:numel(obj)
        obj2{o} = ensureNii(obj{o});
    end
    obj = obj2;
else
    obj = ensureNii(obj);
    obj = {obj};
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureNiiCell.m] ======  

function obj = ensureNii(obj)

%% ENSURENII returns NIfTI for any plausible string, numerical type, NIfTI subclass
%  Usage:  obj = ensureNii(obj)
obj = mlfourd.NIfTI(obj);

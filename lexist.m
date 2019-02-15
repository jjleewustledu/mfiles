function tf = lexist(obj, varargin)
%% LEXIST always returns a logical type
%  @param objName is char or mlio.{IOInterface,HandleIOInterface}.
%  @param varargin is passed on to exist.
%  See also exist.

if (isempty(obj))
    obj = '';
end
if (isa(obj, 'mlio.IOInterface') || isa(obj, 'mlio.HandleIOInterface'))
    obj = obj.fqfilename;
end
if (lstrfind(varargin, 'var'))
    warning('mfiles:likelyUnintendedUsage', ...
        'lexist: received argument ''var'' but variables external to lexist are out of scope; consider using exist');
end

tf = logical(exist(obj, varargin{:}));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/lexist.m] ======  

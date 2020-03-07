function assertSizeEqual(varargin)
%% ASSERTSIZEEQUAL ... 
%  @param required obj1 possessing valid method size.
%  @param required obj2 possessing valid medhod size.
%  @param optional obj3, ..., objN, with identical preconditions.

if (nargin < 2)
    return
end
for v = 1:nargin-1
    assert(all(size(varargin{v}) == size(varargin{v+1})));
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/assertSizeEqual.m] ======  

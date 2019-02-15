function handwarning(exc, varargin)
%% HANDWARNING 
%  Usage:  handwarning(anMException[, ...])
%                                     ^ args to Matlab's native warning beyond MSGID and MESSAGE

assert(isa(exc, 'MException'));
warning('on', 'verbose')
warning('on', 'backtrace')
warning(exc.identifier, exc.message);
if (~isempty(varargin))
    warning(varargin{:})
end


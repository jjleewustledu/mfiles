function handexcept(exc, varargin)
%% HANDEXCEPT
%  Usage:  handexcept(anMException[, ...])
%                                    ^ cf. MException for nonempty varargin.
%  e.g.:  handexcept(ME, 'mlpackage:SomeTypicalError', 'methodIdentifier:  contextual description')
%  @param required exc is an MException.
%  @param varargin conforms to interface of native error() and https://docs.python.org/3/library/exceptions.html .
%  @throws exc, possibly including additional exception causes.

if (isempty(varargin))
    rethrow(exc);
end  
if (~lstrfind(varargin{1}, ':'))
    handexcept(exc, 'mfiles:RuntimeError', varargin{:});
end
exc = addCause(exc, MException(varargin{:}));
rethrow(exc);

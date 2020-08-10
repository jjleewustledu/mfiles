function handwarning(exc, varargin)
%% HANDWARNING switches on native warning()'s verbose and backtrace modes;
%  it provides warning from exc.identifier, exc.message and additional warning from varargin.
%  @param exc is an MException
%  @param varargin are passed to native warning(varargin{:})

assert(isa(exc, 'MException'));
warning('on', 'verbose')
warning('on', 'backtrace')

disp(exc.identifier)
disp(struct2str(exc.stack(1)))
warning(exc.identifier, exc.message);
if (~isempty(varargin))
    warning(varargin{:})
end


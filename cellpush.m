function [ stack ] = cellpush( stack, item )
%% CELLPUSH pushes an object-item onto the object-stack
%  stack = cellpush(stack, item)

if (~iscell(stack) && ~isempty(stack))
    stack = {stack}; 
end
if (~isempty(item))
    stack = [stack item];
end

end


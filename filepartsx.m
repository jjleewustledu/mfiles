function [pth,name,x] = filepartsx(in, x)
%% FILEPARTSX calls fileparts with a priori extension
%  Usage:  [pth,name,x] = filepartsx(in[, x])
%                                         ^ '.nii.gz'; if absent, reduces to fileparts

    if (~ischar(in))
        fprintf('debugging filepartsx.in->%s\n', class(in));
        disp(in);
    end
    assert(ischar(in), 'filepartsx.in->%s', class(in));
    if (exist('x','var'))
        assert(ischar(x),  'filepartsx.x->%s',  class(x));
        if (~strcmp('.', x(1)))
            x = ['.' x];
        end
        found = strfind(in, x);
        if (~isempty(found))
            in = in(1:found(1)-1);      
            [pth,name,name2] = fileparts(in);
            name = [name name2];
            return
        end
    end
    [pth,name,x] = fileparts(in);
end
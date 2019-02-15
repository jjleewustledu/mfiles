function g = concatReflection(varargin)
%% CONCATREFLECTION accepts row or col 1-vectors.
%  @param required 1-vector f
%  @param optional switch is logical; when true, g = [f(T - t) f(t)].
%  @returns 1-vector g as [f(t) f(T - t)] for t = 1:T.  length(g) = 2*length(f).
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.2.0.538062 (R2017a).  Copyright 2017 John Joowon Lee. 

ip = inputParser;
addRequired(ip, 'f', @isnumeric);
addOptional(ip, 'switch', false, @islogical);
parse(ip, varargin{:});

[f,flipped] = ensureRowVector(ip.Results.f);
if (ip.Results.switch)
    g = [fliplr(f) f];
    if (flipped)
        g = ensureColVector(g);
    end
    return
end

g = [f fliplr(f)];
if (flipped)
    g = ensureColVector(g);
end





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/concatReflection.m] ======  

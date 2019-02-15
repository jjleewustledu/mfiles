function objs = repcell(obj, M, N)
%% REPCELL ... 
%   
%  Usage:  objs = repcell(obj, M [,N]) 
%                              ^ number of replications of obj in objs 
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.12.0.62 (R2011a) 
%% $Id$ 

switch (nargin)
    case 2
        objs = cell(1,M);
        for m = 1:M
            objs{m} = obj;
        end
    case 3
        objs = cell(M,N);
        for n = 1:N %#ok<*FORPF>
            for m = 1:M
                objs{m,n} = obj;
            end
        end
    otherwise
        error('mfiles:InputParamOutOfBounds', 'repcell.nargin->%i\n', nargin);
end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/repcell.m] ======  

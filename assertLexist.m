function assertLexist(varargin)
%% ASSERTLEXIST ... 
%  Usage:  assertLexist() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

    ip = inputParser;
    addRequired(ip, 'f', @ischar);
    addOptional(ip, 'typ', 'file', @ischar);
    parse(ip, varargin{:});
    
    assert(lexist(ip.Results.f, ip.Results.typ), ...
        'mfiles:missingFile', ...
        'assertLexist could not find %s in pwd->%s', ip.Results.f, pwd);

end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/assertLexist.m] ======  

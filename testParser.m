function testParser(a, varargin)
%% TESTPARSER ... 
%  Usage:  testParser() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

    ip = inputParser;
    ip.KeepUnmatched = true;
    addRequired( ip, 'a', @isnumeric);
    addParameter(ip, 'B', 2, @isnumeric);
    parse(ip, a, varargin{:});
    disp(ip.Results)
    testParser2(varargin{:});

    function testParser2(varargin)
        
        ip2 = inputParser;
        ip2.KeepUnmatched = true;
        addParameter(ip2, 'C', 3, @isnumeric);
        addParameter(ip2, 'D', 4, @isnumeric);
        addParameter(ip2, 'E', 5, @isnumeric);
        parse(ip2, varargin{:});
        disp(ip2.Results)
    end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/testParser.m] ======  

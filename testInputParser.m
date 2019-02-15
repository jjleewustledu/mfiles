function out = testInputParser(varargin)
%% TESTINPUTPARSER 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.341360 (R2016a) 
%% $Id$ 

ip = inputParser;
addOptional(ip, 'in', 'somethingIn', @ischar);
parse(ip, varargin{:});

ip.Results.in = [ip.Results.in '_appended'];
out = ip.Results.in;







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/testInputParser.m] ======  

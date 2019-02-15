function [s,r] = dbbash(varargin)
%% DBBASH wraps mlbash providing debugging assistance:  calling fprintf if lgetenv('DEBUG').
%  Usage:  dbbash(arg_for_mlbash) 

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.341360 (R2016a) 
%% $Id$ 

if (lgetenv('DEBUG'))
    fprintf('dbbash %s\n', cell2str(varargin));
end
[s,r] = mlbash(varargin{:});






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/dbbash.m] ======  

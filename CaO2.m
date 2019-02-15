function C = CaO2(varargin)
%% CAO2
%  @param [Hgb] is required.
%  @param name 'SpO2' has default value 0.97.
%  @param name 'OxyHgbBinding' has default value 1.34.
%  @param name 'PaO2' has default value 105.
%  @returns OxyHgbBinding * [Hgb] * SpO2 + 0.0031 * PaO2

%% Version $Revision$ was created 9/26/2016 by jjlee,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.341360 (R2016a) 
%% $Id$ 

ip = inputParser;
addRequired( ip, 'Hgb',  @isnumeric);
addParameter(ip, 'SpO2', 0.97, @isnumeric);
addParameter(ip, 'OxyHgbBinding', 1.34, @isnumeric);
addParameter(ip, 'PaO2', 105, @isnumeric);
parse(ip, varargin{:});

C = ip.Results.OxyHgbBinding * ip.Results.Hgb * ip.Results.SpO2 + 0.0031 * ip.Results.PaO2;

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/CaO2.m] ======  

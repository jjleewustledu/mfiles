function c = crc(varargin)
%% CRC 
%  @param char, numeric, ...
%  @param CRC checksum
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

if (1 == nargin)
    c = dec2hex(crc32_vlachos(varargin{:}));
    return
elseif (2 == nargin)
    c = dec2hex(crc32_adler(varargin{:}));
    return
end
error('mfiles:ValueError', 'crc nargin->%i', nargin);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/crc.m] ======  

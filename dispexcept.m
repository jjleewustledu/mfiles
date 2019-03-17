function dispexcept(ME, varargin)
%% DISPEXCEPT calls getReport and then rethrows the exception
%  @param MException
%  @param varargin conforms to interface of native error() and https://docs.python.org/3/library/exceptions.html .
%  see also:  handexcept

%  Version $Revision$ was created 2017 by jjlee,  
%  last modified 20190313 165530 and checked into repository MATLAB-Drive/mfiles,  
%  developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2018 John Joowon Lee. 

getReport(ME)
handexcept(ME, varargin{:});

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/dispexcept.m] ======  

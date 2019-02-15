function varargout = gzipExisting(varargin)
%% GZIPEXISTING decorates gunzip and catches MException.
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.1.0.441655 (R2016b).  Copyright 2017 John Joowon Lee. 

try
    varargout = gzip(varargin{:});
catch ME
    handwarning(ME);
end





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/gzipExisting.m] ======  

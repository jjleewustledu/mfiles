function fp = ensureFileprefix(fp, varargin)
%% ENSUREFILEPREFIX returns a fileprefix string, type-casting as needed
%   
%  Usage:  fp = ensureFileprefix(fp) 
%  Uses:   ensureFilename
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/ensureFileprefix.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

fp = fileprefix(ensureFilename(fp), varargin{:});



% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureFileprefix.m] ======  

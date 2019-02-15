function fp = fullfileprefixes(varargin)
%% FULLFILEPREFIXES decorates fullfile with fileprefixes
%  Usage:  file_prefix = fullfileprefix([folder, folder2, ..., ]filename) 
% 
%% Version $Revision: 2292 $ was created $Date: 2012-10-30 20:08:23 -0500 (Tue, 30 Oct 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-10-30 20:08:23 -0500 (Tue, 30 Oct 2012) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/fullfileprefixes.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

fp = fileprefixes(fullfiles(varargin{:}));




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/fullfileprefix.m] ======  

function fn = fullfilenames(varargin)
%% FULLFILENAMES decorates fullfile with filenames
%  Usage:  file_name = fullfilename([folder, folder2, ..., ]fileprefix) 
% 
%% Version $Revision: 2292 $ was created $Date: 2012-10-30 20:08:23 -0500 (Tue, 30 Oct 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-10-30 20:08:23 -0500 (Tue, 30 Oct 2012) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/fullfilenames.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

fn = filenames(fullfiles(varargin{:}));





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/fullfilename.m] ======  

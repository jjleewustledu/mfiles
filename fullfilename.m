function fn = fullfilename(varargin)
%% FULLFILENAME decorates fullfile with filename
%  Usage:  file_name = fullfilename([folder, folder2, ..., ]fileprefix) 
% 
%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/fullfilename.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

for v = 1:length(varargin)
    if (isa(varargin{v}, 'mlfourd.INIfTI'))
        varargin{v} = varargin{v}.fileprefix;
    end
end
fn = filename(fullfile(varargin{:}));





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/fullfilename.m] ======  

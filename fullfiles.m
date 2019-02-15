function files = fullfiles(varargin)
%% FULLFILES adds additional functionality to fullfile:  accepts cell-arrays 
%   
%  Usage:  files = fullfiles(dir1[, dir2, dir3, ..., filename])
%          ^ string or cell-array of
%                            ^ directory names and filename
%                              only filename may be a cell-array
%% Version $Revision: 1209 $ was created $Date: 2011-07-29 15:43:03 -0500 (Fri, 29 Jul 2011) $ by $Author: jjlee $  
%% and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/fullfiles.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 

vlen = length(varargin);

if (iscell(varargin{vlen}))
    
    dstr  = '';
    for d = 1:vlen-1 %#ok<*FORPF,*FORFLG>
        dstr = fullfile(dstr, varargin{d});
    end
    files = varargin{vlen};
    for f = 1:length(files)
        files{f} = fullfile(dstr, files{f});
    end
else
    files = fullfile(varargin{:});
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/from_pth.m] ======  

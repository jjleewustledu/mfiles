function fns = ensureFilenames(obj, varargin)
%% ENSUREFILENAMES ... 
%  Usage:  filenames = ensureFilenames(obj) 
%          ^ cell                      ^ object, length > 0
%
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/ensureFilenames.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

assert(~isempty(obj));
fns = cell(1, length(obj));
if (iscell(obj) || ...
       isa(obj, 'mlfourd.ImagingComponent'))
    for o = 1:length(obj)
        fns{o} = ensureFilename(obj{o}, varargin{:});
    end
elseif (isa(obj, 'mlpatterns.List'))
    for o = 1:length(obj)
        fns{o} = ensureFilename(obj.get(o), varargin{:});
    end
else
    fns = ensureFilename(obj, varargin{:});
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureFilenames.m] ======  

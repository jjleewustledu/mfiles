function fn = ensureFilename(fn, varargin)
%% ENSUREFILENAME returns a filename string, type-casting as needed
%   
%  Usage:  fn = ensureFilename(fn) 
%  Uses:   filename
%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/ensureFilename.m $ 
%% Developed on Matlab 7.14.0.739 (R2012a) 
%% $Id$ 

if (~ischar(fn) && length(fn) > 1)
    error('mfiles:UnsupportedType', 'ensureFilename.fn was a %s with length %i', class(fn), length(fn));
end
if (iscell(fn))
    fn = ensureFilename(fn{1});
end
if (isstruct(fn))
    try
        fn = ensureFilename(fn.fqfilename);
    catch ME
        handerror(ME);
    end
end
if (isa(fn, 'mlfourd.ImagingComponent'))
    fn = ensureFilename(fn{1});
end
if (isa(fn, 'mlfourd.INIfTI'))
    fn = ensureFilename(fn.fqfilename);
end
assert(ischar(fn), 'mfiles:UnexpectedType', 'ensureFilename could not recognize class(fn) -> %s', class(fn));
fn = filename(fn, varargin{:});




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureFilename.m] ======  

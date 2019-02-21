function fname = fieldcoefcast(varargin)
%% FIELDCOEFCAST ... 
%   
%  Usage:  field_coef_filename = fieldcoefcast(obj[, obj2, obj3, ...]) 
%          ^ 
%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/fieldcoefcast.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 

varargin1 = varargin;
if (iscell(varargin{1}))
    varargin1 = varargin{1}; end
[p,fname] = filepartsx(imcast(varargin1{1}, 'fqfilename'), mlfourd.NIfTIInfo.FILETYPE_EXT);
for v = 2:length(varargin1)
    [p,f] = filepartsx(imcast(varargin1{v}, 'fqfilename'), mlfourd.NIfTIInfo.FILETYPE_EXT);
    fname = [fname '_on_' f]; %#ok<AGROW>
end
fname = fullfile(p, [fname '_warpcoef.nii.gz.']);








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/affcast.m] ======  






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/fieldcoefcast.m] ======  

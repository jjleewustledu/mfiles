function fourdfp_to_nifti(files)
%% FOURDFP_TO_NIFTI ... 
%   
%  Usage:  fourdfp_to_nifti(files) 
%                           ^ string; '*' is allowed as specified by dir2cell 
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/fourdfp_to_nifti.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 

if (iscell(files))
    for f = 1:length(files)
        fourdfp_to_nifti(files{f});
    end
end
assert(ischar(files));

flist = dir2cell(files);
for f = 1:length(flist) %#ok<*FORPF>
    
    assert(lexist([flist{f} '.hdr'], 'file'), ['fourdfp_to_nifti could not find:  ' flist{f} '.hdr']);
    mlbash(['fslchfiletype NIFTI_GZ ' flist{f} '.hdr']);
    flip4d(NIfTI.load(flist{f}), 'y');
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/fourdfp_to_nifti.m] ======  

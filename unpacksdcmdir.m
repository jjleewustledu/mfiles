function [s,r] = unpacksdcmdir(dat, idx0, idx)
%% UNPACKSDCMDIR ... 
%   
%  Usage:  [s,r] = unpacksdcmdir(dat, [idx0 idx])
%           ^ status number and stdout/stderr
%                                ^ struct ieh cell-arrays mm_p_date, mm_p, idx_mpr
%                                      ^ index range, 2-vec, first through last
%% Version $Revision: 1220 $ was created $Date: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/unpacksdcmdir.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 

pwd0 = pwd; s = -1; r = 'initial unpacksdcmdir';
% DEBUGGING dat(33).idx_mpr = 5;
for id = idx0:idx %#ok<*FORFLG>
    
    if (dat(id).idx_mpr > 0 && dat(id).idx_mpr ~= 3)
        assert(7 == exist(fullfile(pwd0, dat(id).mm_p_date), 'dir'));
        cd(fullfile(pwd0, dat(id).mm_p_date, 'Magnetom', '')); 
        setenv('SUBJECTS_DIR', pwd);
        [s,r] = mlbash(sprintf( ...
                'unpacksdcmdir -src Dicom -targ unpack -fsfast -run %i mpr mgz 001.mgz\n', ...
                dat(id).idx_mpr));
        cd(pwd0);
    end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/unpacksdcmdir.m] ======  

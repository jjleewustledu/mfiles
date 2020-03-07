function construct_phantom_stats()
%% CONSTRUCT_PHANTOM_STATS walks the top-level folder containing CCIR_00* folders, then generates stats for all 
%  enclosd phantom scans of calibration materials.
%
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1296695 (R2019b) Update 4.  Copyright 2020 John Joowon Lee. 

cd('/data/nil-bluearc/raichle/PPGdata/jjlee/Singularity')
for proj = globFoldersT('CCIR_00*')
    pwd0 = pushd(proj{1});
    for ses = globFoldersT('ses-E*')
        pwd1 = pushd(ses{1});
        fdgs = globFoldersT('FDG_DT*-Converted-*');
        if ~isempty(fdgs)
            loc = fullfile(proj{1}, ses{1}, fdgs{end});
            construct_phantom(loc, 'getstats', true);
        end
        popd(pwd1);
    end
    popd(pwd0)
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/construct_phantom_stats.m] ======  

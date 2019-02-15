function [s,r,dat] = reconall(dat, idx0, idx)
%% RECONALL launches recon-all over indexed studies; logs to ./reconall.log 
%   
%  Usage:  [s,r,dat] = unpacksdcmdir(dat, idx0, idx)
%           ^ ^ status number and stdout/stderr
%               ^ data struct with successful indices -> -1
%                                    ^ data struct with cell-arrays mm_p_date, mm_p, idx_mpr
%                                         ^     ^ index range to process, first through last
%% Version $Revision: 1220 $ was created $Date: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/reconall.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 

% DEBUGGING dat(33).idx_mpr = 5;
if (~exist('idx','var')); idx = idx0; end
pwd0 = pwd; s = -1; r = 'initial reconall'; tmp = '';
for id = idx0:idx %#ok<*FORFLG>
    
    if (dat(id).idx_mpr > 0 && dat(id).idx_mpr ~= 3)
        try
            assert(7 == exist(fullfile(pwd0, dat(id).mm_p_date, 'Magnetom', ''), 'dir'));
            cd(               fullfile(pwd0, dat(id).mm_p_date, 'Magnetom', '')); 
            % doesn't persist:  setenv('SUBJECTS_DIR', pwd);
            tmp   = 'echo Matlab.reconall is working in:  `pwd` >> /data/cvl/np755/reconall_pwd.log 2>&1 &\n';
            [s,r] = mlbash(tmp); %#ok<*ASGLU>
            if (dat(id).idx_mpr < 10)
                tmp   = sprintf( ...
                        'export SUBJECTS_DIR=`pwd`; recon-all -s %s -i unpack/mpr/00%i/001.mgz >> reconall.log 2>&1\n', ...
                         dat(id).mm_p, dat(id).idx_mpr)
                [s,r] = mlbash(tmp);
            else
                tmp   = sprintf( ...
                        'export SUBJECTS_DIR=`pwd`; recon-all -s %s -i unpack/mpr/0%i/001.mgz >> reconall.log 2>&1\n', ...
                         dat(id).mm_p, dat(id).idx_mpr)
                [s,r] = mlbash(tmp);
            end

            tmp   = sprintf( ...
                'export SUBJECTS_DIR=`pwd`; recon-all  -all -subjid %s >> reconall.log 2>&1 &\n', dat(id).mm_p)
            [s,r] = mlbash(tmp);
            dat(id).idx_mpr = -1;
        catch ME
            handerror(ME, 'mfiles:unknownError', ['mfiles.reconall.id->' num2str(id) ', mm_p_date->' dat(id).mm_p_date '\n']);
        end
        cd(pwd0);
    end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/unpacksdcmdir.m] ======  

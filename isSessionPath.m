function tf = isSessionPath(pth)
%% ISSESSIONPATH checks that the passed filesystem path exists and is a session-path, not
%  one of the canonical subpaths:   Avanto, bem, ECAT_EXACT, fsl, label, laif, Magnetom, mri, perfusion_4dfp, 
%  scripts, stats, surf, touch, trash, Symphony, Trio
%   
%  Usage:  tf = isSessionPath(filesystem_path)

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

CANONICAL_FOLDERS =  ...
    {'Avanto' 'bem' 'ECAT_EXACT' 'fsl' 'label' 'laif' 'Magnetom' 'mri' 'perfusion_4dfp' ... 
     'scripts' 'stats' 'surf' 'touch' 'trash' 'Symphony' 'Trio' };
SESSION_LABEL = {'mm' 'p'};
tf = true;
if (~lexist(pth, 'dir'))
    tf = false; return; end
if (lstrfind(pth, CANONICAL_FOLDERS))
    tf = false; return; end
if (~lstrfind(pth, SESSION_LABEL))
    tf = false; return; end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/isSessionPath.m] ======  

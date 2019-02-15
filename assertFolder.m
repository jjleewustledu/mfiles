function assertFolder(aFolder)
%% ASSERTFOLDER asserts the enclosing folder in the path to be aFolder
%  Usage:  assertFolder(aFolder) 

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

[~,folder] = fileparts(pwd);
assert(strcmp(folder, aFolder));

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/assertFolder.m] ======  

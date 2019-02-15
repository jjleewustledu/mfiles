function fqdns = testParcd()
%% TESTPARCD ... 
%  Usage:  testParcd() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.341360 (R2016a) 
%% $Id$ 

cd('/scratch/jjlee/tmp');
dt = mlsystem.DirTool(pwd);
fqdns = dt.fqdns;
parfor p = 1:length(fqdns);
    cd(fqdns{p});
    fqdns{p} = pwd;
    fprintf('worker %i: pwd->%s\n', p, pwd);
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/testParcd.m] ======  

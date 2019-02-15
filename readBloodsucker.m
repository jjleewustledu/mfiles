function obj = readBloodsucker(obj, pnum)
%% READBLOODSUCKER ... 
%  Usage:  struct = readBloodsucker(struct, p-number) 

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

pwd0 = pwd;
dt = mlfourd.DirTool(sprintf('mm0*_%s*', pnum));
cd(dt.fqdns{1});
mmnum = str2mmnum(pwd);
mmnum = [mmnum(1:4) '_' mmnum(6:end)];
cd('ECAT_EXACT/pet');

import mlpet.*;
obj.(mmnum).(pnum).crv = CRV([pnum 'ho1']);
obj.(mmnum).(pnum).dcv = DCV([pnum 'ho1']);
cd(pwd0);







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/readBloodsucker.m] ======  

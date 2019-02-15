function retrieveFromChpc()

%% RETRIEVEFROMCHPC ... 
%  Usage:  retrieveFromChpc() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

hyglys = { 'HYGLY05' 'HYGLY08' 'HYGLY11' 'HYGLY24' 'HYGLY25' };
visits = { {'V2'} {'V1'} {'V2'} {'V1'} {'V2'} };e 

studyd = mlraichle.StudyData;
for h = 1:length(hyglys)
    sessd = mlraichle.SessionData( ...
        'studyData', studyd, ...
        'sessionPath', fullfile(mlraichle.RaichleRegistry.instance.subjectsDir, hyglys{h}, ''));
    t4rb = mlraichle.T4ResolveBuilder('sessionData', sessd);
    t4rb.retrieveNAC('visits', visits{h});
end





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/retrieveFromChpc.m] ======  

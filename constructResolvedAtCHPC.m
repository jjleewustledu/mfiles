function constructResolvedAtCHPC()
%% CONSTRUCTRESOLVEDATCHPC ... 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

mlraichle.HyperglycemiaDirector.constructResolvedRemotely('sessionsExpr', 'HYGLY25*', 'visitsExpr', 'V1*', 'tracer', 'OO')
mlraichle.HyperglycemiaDirector.constructResolvedRemotely('sessionsExpr', 'HYGLY25*', 'visitsExpr', 'V2*', 'tracer', {'OO' 'HO'}, 'scanList', 1:1)

mlraichle.HyperglycemiaDirector.constructResolvedRemotely('sessionsExpr', 'HYGLY26*', 'visitsExpr', 'V1*', 'tracer', 'OO')
mlraichle.HyperglycemiaDirector.constructResolvedRemotely('sessionsExpr', 'HYGLY26*', 'visitsExpr', 'V1*', 'tracer', 'HO', 'scanList', 1:1)
mlraichle.HyperglycemiaDirector.constructResolvedRemotely('sessionsExpr', 'HYGLY35*', 'visitsExpr', 'V1*', 'tracer', 'HO', 'scanList', 2:2)
mlraichle.HyperglycemiaDirector.constructResolvedRemotely('sessionsExpr', 'HYGLY35*', 'visitsExpr', 'V2*', 'tracer', 'OC', 'scanList', 2:2)
mlraichle.HyperglycemiaDirector.constructResolvedRemotely('sessionsExpr', 'HYGLY36*', 'visitsExpr', 'V2*', 'tracer', 'OC', 'scanList', 2:2)
mlraichle.HyperglycemiaDirector.constructResolvedRemotely('sessionsExpr', 'HYGLY36*', 'visitsExpr', 'V2*', 'tracer', 'OO')






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolvedAtCHPC.m] ======  

function dt_ = setPreferredTimeZone(dt_)
%% SETPREFERREDTIMEZONE
%  @param dt_ is datetime
%  @return dt_ is datetime with adjusted TimeZone
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2018 John Joowon Lee. 

dt_.TimeZone = mlpipeline.ResourcesRegistry.instance().preferredTimeZone;

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/setPreferredTimeZone.m] ======  

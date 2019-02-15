function tf = hostnameMatch(toMatch)

%% HOSTNAMEMATCH ... 
%  @param toMatch is a string to match
%  @returns tf logical

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.341360 (R2016a) 
%% $Id$ 

[~,hn] = mlbash('hostname -f');
tf = lstrfind(hn, toMatch);








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/hostnameMatch.m] ======  

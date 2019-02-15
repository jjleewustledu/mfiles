function pwd0 = pushd(pth)
%% PUSHD ... 
%  Usage:  location0 = pushd(location) 
%          ^                 ^ isdir(...)
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

if (isempty(pth))
    pwd0 = pwd;
    return
end

assert(isdir(pth));
pwd0 = pwd;
try
    cd(pth);
catch ME
    handerror(ME);
end









% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/pushd.m] ======  

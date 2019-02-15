function [pwdLast,pwd0] = popd(pwd0)
%% POPD ... 
%  Usage:  [locationLast,location0] = popd(location0) 
%           ^            ^                 ^ isdir(...)
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

pwdLast = pwd;
assert(isdir(pwd0));
try
    cd(pwd0);
catch ME
    handerror(ME);
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/popd.m] ======  

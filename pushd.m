function pwd0 = pushd(pwd1)
%% PUSHD ... 
%  @param pwd1 is the pwd after calling pushd.
%  @return pwd0 is the pwd before calling pushd.

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

if isempty(pwd1)
    pwd0 = pwd;
    return
end
if ~isfolder(pwd1)
    error('mfiles:RuntimeError', 'pushd(%s): No such file or directory', pwd1)
end
pwd0 = pwd;
cd(pwd1);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/pushd.m] ======  

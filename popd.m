function pwd1 = popd(pwd0)
%% POPD 
%  @param pwd0 is the pwd before call to pushd.
%  @return pwd1 is the pwd after call to pushd.

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

pwd1 = pwd %#ok<NOPRT> 
assert(isfolder(pwd0));
cd(pwd0)

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/popd.m] ======  

function [pth,prefix] = fileprefixparts(fstr)
%% FILEPREFIXPARTS
%  @param fileprefix, possibly fully-qualified; no file suffix is assumed so that '.' may be used in fileprefixes.
%  @return [path,file-prefix] = fileprefixparts(file-string) 

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

[pth,p1, p2] = fileparts(fstr);
prefix = [p1 p2];








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/fileprefixparts.m] ======  

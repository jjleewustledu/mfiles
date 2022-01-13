function tf = isfile_4dfp(name)
%% ISFILE_4DFP assesses that necessary 4dfp files exist on the filesystem.
%  Args:
%      name (text):  name | name.4dfp | name.4dfp.{hdr,ifh,img}.
%  Returns:
%      tf: that name.4dfp.{hdr,ifh,img} all exist.
%  Warnings:
%      mfiles:FileNotFoundError if name.4dfp.img.rec is missing.
%
%  Created 09-Dec-2021 13:11:17 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.11.0.1809720 (R2021b) Update 1 for MACI64.  Copyright 2021 John J. Lee.

assert(istext(name))
name = myfileprefix(name);
name = convertCharsToStrings(name);
if ~isfile(name + ".4dfp.img.rec")
    warning("mfiles:FileNotFoundError", "isfile_4dfp could not find " + name + ".4dfp.img.rec")
end
tf = isfile(name + ".4dfp.hdr") & isfile(name + ".4dfp.ifh") & isfile(name + ".4dfp.img");

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/isfile_4dfp.m] ======  

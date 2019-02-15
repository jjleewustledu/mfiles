function [sta, msg, ids] = copyfiles(sources, varargin)
%% COPYFILES
%  Usage:  [statuses,messages,messageids] = copyfiles(sources [, dest, force]) 
%           ^ same as copyfile, but may be cell-arrays
%                                                     ^ same as copyfile, but may be cell-array, may have wildcards,
%                                                       adds .nii.gz as needed, preserves path-information
%                                                                       ^ char for forced copies, 'f'
%  See also:  movefiles, copyfile, filesystemOps

%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

[sta, msg, ids] = filesystemOps(@copyfile, sources, varargin{:});
        
% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/copyfiles.m] ======  

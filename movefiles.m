function [sta, msg, ids] = movefiles(sources, varargin)
%% MOVEFILES%   
%  Usage:  [statuses,messages,messageids] = movefiles(sources [, dest, force]) 
%           ^ same as movefile, but may be cell-arrays
%                                                     ^ same as movefile, but may be cell-array, may have wildcards,
%                                                       adds .nii.gz as needed, preserves path-information
%                                                                       ^ char for forced copies, 'f'
%  See also:  copyfiles, movefile, filesystemOps

%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

[sta, msg, ids] = filesystemOps(@movefile, sources, varargin{:});
        
% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/copyfiles.m] ======  

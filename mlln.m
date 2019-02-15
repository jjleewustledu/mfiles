function [status,stdout] = mlln(varargin)
%% MLLN wraps posix command ln -s
%   
%  Usage:  [status,stdout] = mlln(source, target)
%          [status,stdout] = mlln(source, source2, ..., target)
%                                 ^       ^ source & target filenames or multiple source filenames
%                                                       ^ target filename or target directory
%           fileprefixes will be converted to filenames ending in .nii.gz
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.10.0.499 (R2010a) 
%% $Id$ 
arglist = '';
for v = 1:length(varargin)
    fname   = filename(varargin{v});  
    arglist = horzcat(arglist, [' ' fname]);  %#ok<*AGROW>
end

[status,stdout] = mlbash(['ln -s ' arglist], '-echo');


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mfiles/mlbash.m] ======  

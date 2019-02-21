function fn = myfilename(varargin)
%% MYFILENAME ... 
%  @param name represents any filesystem string
%  @param ext is the filename extension to enforce (default is '.nii.gz')
%  @returns fn, an imaging filename based on name, with assurance of the requrested file extension 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
%% $Id$ 

ip = inputParser;
addRequired(ip, 'name', @ischar);
addOptional(ip, 'ext', mlfourd.NIfTIInfo.FILETYPE_EXT, @ischar); 
parse(ip, varargin{:});

[p,f] = myfileparts(ip.Results.name);
fn = fullfile(p, [f ip.Results.ext]);








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/myfilename.m] ======  

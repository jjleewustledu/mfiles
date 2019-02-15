function fqfn = backupn(varargin)
%% BACKUPN makes backup copies of files or folders, keeping as many as n backup versions.
%  @param fqfn is a fully-qualified filename
%  @param n is an integer
%  @throws error mfiles:backupRejected
%  See also:  mlfourdfp.FourdfpVisitor.backupn

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

import mlfourdfp.*;
ip = inputParser;
addRequired( ip, 'fqfn', @(x) lexist(x, 'file') || isdir(x));
addOptional( ip, 'n', 1, @isnumeric);
addParameter(ip, 'tag', '_backup', @ischar);
parse(ip, varargin{:});

dt = mlsystem.DirTool([ip.Results.fqfn ip.Results.tag '*']);
if (length(dt.fqfns) + length(dt.fqdns) < ip.Results.n)
    if (isdir(ip.Results.fqfn))
        fqfn = sprintf('%s%sD%s', ip.Results.fqfn, ip.Results.tag, datestr(now, 30));
        copyfile(ip.Results.fqfn, fqfn);
    else        
        [pth,fp,ext] = myfileparts(ip.Results.fqfn);
        fqfn = sprintf('%s%sD%s%s', fullfile(pth, fp), ip.Results.tag, datestr(now, 30), ext);
        copyfile(ip.Results.fqfn, fqfn);
    end
    return
end
error('mfiles:backupRejected', 'backupn.ip.Results.n -> %i', ip.Results.n);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/backupn.m] ======  

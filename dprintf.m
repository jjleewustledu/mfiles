function dprintf(varargin)
%% DPRINTF calls fprintf if mlpipeline.PipelineRegistry.debugging
%   
%  Usage:  dprintf(format_string, var, var2, ...) 
%                  ^ cf. fprintf

%% Version $Revision: 2551 $ was created $Date: 2013-08-22 04:37:16 -0500 (Thu, 22 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-22 04:37:16 -0500 (Thu, 22 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/dprintf.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

if (mlpipeline.PipelineRegistry.instance.debugging)
    fprintf(varargin{:});
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/vprintf.m] ======  

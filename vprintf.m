function vprintf(varargin)
%% VPRINTF calls fprintf if mlpipeline.PipelineRegistry.verbose
%   
%  Usage:  vprintf(format_string, var, var2, ...) 
%                  ^ cf. fprintf

%% Version $Revision: 2473 $ was created $Date: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-08-10 21:38:44 -0500 (Sat, 10 Aug 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/vprintf.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

if (mlpipeline.PipelineRegistry.instance.verbose)
    fprintf(varargin{:});
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/vprintf.m] ======  

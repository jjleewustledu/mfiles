function deprecated(todep)

%% DEPRECATED will issues warnings or errors according to mlpipeline.PipelineRegistry.instance.deprecationSeverity
%   
%  Usage:  deprecated(string_descriptor)
% 
%% Version $Revision: 2306 $ was created $Date: 2013-01-12 17:49:33 -0600 (Sat, 12 Jan 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-01-12 17:49:33 -0600 (Sat, 12 Jan 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/deprecated.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 

pinst = mlpipeline.PipelineRegistry.instance;
switch (lower(pinst.deprecationSeverity))
    case 'warning'
        warning('mlpipeline:pragmaticWarning', ...
              'mfiles.deprecated:  WARNING:  %s has been deprecated by mlpipeline.PipelineRegistry..........\n', todep);
    otherwise
        error('mlpipeline:pragmaticInterruption', ...
              'mfiles.deprecated:  ERROR:  %s has been severely deprecated by mlpipeline.PipelineRegistry..........\n', todep);
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/deprecated.m] ======  

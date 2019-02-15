function startupTests(varargin)
%% STARTUPTESTS ... 
%  Usage:  startupTests([list-of-tests]) 
%                        ^ packageName.TestName, or cell-array of, or 'all'
%
%% Version $Revision: 2650 $ was created $Date: 2013-09-21 17:59:39 -0500 (Sat, 21 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-21 17:59:39 -0500 (Sat, 21 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/startupTests.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$ 

setenv('MLUNIT_TESTING', '1');
if (verLessThan('matlab', '8.2'))
    startupTests_R2013a(varargin{:});
    return;
end
if (verLessThan('matlab', '8.3'))
    startupTests_R2013b(varargin{:});
    return;
end
setenv('MLUNIT_TESTING', '0');




% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/runtests_fsl.m] ======  

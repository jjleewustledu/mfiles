function ensureSerial
%% ENSURESERIAL throws an exception if environment is not serial   
%  Usage:  ensureSerial
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/ensureSerial.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

if (parpool('size') > 0)
    throw( ...
        MException('mfiles:StateAssertionFailed', 'ensureSerial.parpool(''size'')->%i', parpool('size')));
    parpool('close');
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureSerial.m] ======  

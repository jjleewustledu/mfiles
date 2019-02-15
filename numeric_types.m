function carray = numeric_types()
%% NUMERIC_TYPES returns a cell array of strings specifying support numeric types;
%  useful for switch(class(obj)) ... case numeric_types
%
%% Version $Revision: 1209 $ was created $Date: 2011-07-29 15:43:03 -0500 (Fri, 29 Jul 2011) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2011-07-29 15:43:03 -0500 (Fri, 29 Jul 2011) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/numeric_types.m $ 
%% Developed on Matlab 7.12.0.635 (R2011a) 
%% $Id$

carray = {'uint8' 'int8' 'uint16' 'int16' 'uint32' 'int32' 'uint64' 'int64' 'float' 'single' 'double' 'dip_image' 'logical'};

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/numeric_types.m] ======  

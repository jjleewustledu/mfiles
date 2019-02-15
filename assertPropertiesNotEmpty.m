function assertPropertiesNotEmpty(obj)
%% ASSERTPROPERTIESNOTEMPTY enumerates the public properties of an object and asserts that they are not empty.
%  Usage:  assertPropertiesNotEmpty(obj) 

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

propNames = properties(obj);
for p = 1:length(propNames)
    assert(~isempty(obj.(propNames{p})));
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/assertPropertiesNotEmpty.m] ======  

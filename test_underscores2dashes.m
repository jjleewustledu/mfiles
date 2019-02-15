function str = test_underscores2dashes(str)
%% TEST_UNDERSCORES2DASHES ...   
%  Usage:  test_underscores2dashes() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

    idxs = strfind(str, '_');
    for x = 1:length(idxs)
        str(idxs(x)) = '-';
    end
end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/test_underscores2dashes.m] ======  

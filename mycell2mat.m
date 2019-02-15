function m = mycell2mat(c)
%% MYCELL2MAT ... 
%  Usage:  m = mycell2mat(c) 
%          ^ numeric      ^ cell-array
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

sizec = size(c);
assert(2 == length(sizec));

m = nan(size(c));
for k = 1:sizec(2)
    for j = 1:sizec(1)
        if (~isempty(c{j,k}))
            m(j,k) = c{j,k};
        end
    end
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/mycell2mat.m] ======  

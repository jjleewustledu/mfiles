function [t4,fqfp,s,r] = testImgreg4dfp(f1, f2)
%% TESTIMGREG4DFP ... 
%  Usage:  testImgreg4dfp() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.1.0.441655 (R2016b).  Copyright 2018 John Joowon Lee. 

fv = mlfourdfp.FourdfpVisitor;
t4 = ''; fqfp = ''; s = nan; r = '';
try
    [t4,fqfp,s,r] = fv.align_2051('dest', f1, 'source', f2);
catch ME
    fprintf('t4->%s\n',   t4);
    fprintf('fqfp->%s\n', fqfp);
    fprintf('s->%i\n',    s);
    fprintf('r->%s\n',    r);
    dispexcept(ME);
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/testImgreg4dfp.m] ======  

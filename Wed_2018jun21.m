function t1 = Wed_2018jun21()
%% WED_2018JUN21 ... 
%  Usage:  Wed_2018jun21() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

import mlsystem.*;
ht = DirTools({'HYGLY2*' 'HYGLY3*' 'HYGLY4*'});

c = {};
K1 = [];
k2 = [];
k3 = [];
k4 = [];
Dt = [];
subj = {};
vs = [];
cd(fullfile(getenv('PPG'), 'jjlee2', ''));

for h = 1:length(ht.dns)
    pwd0 = pushd(fullfile(ht.fqdns{h}, 'Vall', ''));
    for v = 1:4
        txt = DirTool(sprintf('cmrglcv%i*wb*.txt', v));
        if (~isempty(txt.fqfns) && lexist(txt.fqfns{1}, 'file'))
            t = readtable(txt.fqfns{1});
            c = [c; t.cmrglc];
            K1 = [K1; t.K1];
            k2 = [k2; t.k2];
            k3 = [k3; t.k3];
            k4 = [k4; t.k4];
            Dt = [Dt; t.Dt];
            subj = [subj; ht.dns{h}];
            vs = [vs; v];
        end
    end
    popd(pwd0);
end

t1 = table(subj, vs, c, K1, k2, k3, k4, Dt, 'VariableNames', {'subj' 'vs' 'c' 'K1' 'k2' 'k3' 'k4' 'Dt'});
writetable(t1, 'Wed_2018jun20_CMRglcAufbau.xlsx');






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/Wed_2018jun21.m] ======  

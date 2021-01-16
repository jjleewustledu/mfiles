function aif2json(mat_file)
%% AIF2JSON opens mat_file, encodes Matlab array named aif to JSON field named aif and writes
%  json_file with identical fileprefix as mat_file.
%  e.g.:  >> aif2json('DispersedAerobicGlycolysisKit_constructCbvWhilebrain_dt20210103197449.mat') 
%
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.9.0.1538559 (R2020b) Update 3.  Copyright 2021 John Joowon Lee. 

m = load(mat_file);
if ~isfield(m, 'aif')
    error('mfiles:RuntimeError', 'aif2json could not find aif array')
end
j.aif = m.aif;

fid = fopen([myfileprefix(mat_file) '.json'], 'w');
fprintf(fid, jsonencode(j));
fclose(fid);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/aif2json.m] ======  

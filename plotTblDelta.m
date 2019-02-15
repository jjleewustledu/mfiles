function [h1,h2] = plotTblDelta(tbl, tlabel)
%% PLOTTBLDELTA ... 
%  Usage:  load('/Users/jjee/Box\ Sync/Arbelaez/2018feb2');
%          [h1,h2] = plotTblDelta(tbl_ctrl1, 'controls day 1') 

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2018 John Joowon Lee. 

assert(istable(tbl));
assert(ischar(tlabel));
Nrows      = size(tbl,1);
Nsubj      = Nrows/4;
glcLevels  = [90 65 55 45]';
subcortCol = 4:17;
cortCol    = 18:85;

tblDelta = tbl;
baseRow = [];
for r = 1:Nrows
    if (tbl.GlucoseLevel(r) == 90)
        assert(mod(r-1,4) == 0);
        baseRow = tbl(r,:);
    end
    for c = 4:86
        tblDelta{r,c} = tbl{r,c} - baseRow{1,c};
    end
end

figure; 
h1 = plot( ...
    repmat(glcLevels,Nsubj,1), tblDelta{:,subcortCol}, '.'); 
title(sprintf('subcortical FreeSurfer regions, %s', tlabel)); 
xlabel('glc (mg/dL)'); ylabel('\Delta CBF (mL/min/100g from baseline)'); 
axis([35 100 -80 80]);
%set(a1, 'XDir', 'reverse');

figure; 
h2 = plot( ...
    repmat(glcLevels,Nsubj,1), tblDelta{:,cortCol}, '.'); 
title(sprintf('cortical FreeSurfer regions, %s', tlabel)); 
xlabel('glc (mg/dL)'); ylabel('\Delta CBF (mL/min/100g from baseline)'); 
axis([35 100 -80 80]);
%set(a2, 'XDir', 'reverse');


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/plotTblDelta.m] ======  

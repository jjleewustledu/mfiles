%ROIS_SCATTER plots results from the rois_skeleton C# solution
%
%  SYNOPSIS:  rois_scatter(x, y, itsTitle)
%             rois_scatter(x, y, itsTitle, colorString)
%
%         x:           matlab array or dipimage object of abscissa data values
%         y:           matlab array or dipimage object of ordinate data values
%         itsTitle:    string
%         colorString: e.g., left lesion -> 'rrrrrrbbbbbb', right lesion -> 'bbbbbbrrrrrr'
%
%  SEE ALSO:  gscatter, myscatter
%
% $Id$
%
function rois_scatter(x, y, itsTitle, varargin)

% convert to matlab arrays
if (isa(x, 'dip_image')) x = double(x); end
if (isa(y, 'dip_image')) y = double(y); end
        
group_byregion = { 
    'caudate'; 'caudate'; 'caudate'; 'caudate'; 'caudate'; 'caudate'; 'caudate'; 'caudate'; 'caudate'; 'caudate'; 'caudate'; 'caudate'; 'caudate'; 
    'cerebellum'; 
    'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 'grey'; 
    'hippocampus'; 'hippocampus'; 'hippocampus'; 'hippocampus'; 'hippocampus'; 'hippocampus'; 
    'putamen'; 'putamen'; 'putamen'; 'putamen'; 'putamen'; 'putamen'; 'putamen'; 'putamen'; 'putamen'; 'putamen'; 'putamen'; 'putamen'; 
    'thalamus'; 'thalamus'; 'thalamus'; 'thalamus'; 'thalamus'; 'thalamus'; 'thalamus'; 'thalamus'; 'thalamus'; 'thalamus'; 'thalamus'; 'thalamus'; 
    'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white'; 'white' 
    };

colors2 = 'rrrbbbbb';
colors3 = 'rgb';
colors6 = 'kbcymr';
colors7 = 'kbcgymr';
colors  = colors7;

symbols = 'ooooooo'; %%% 's^v+s^v+'; %%% 's^v+o'

sizes = [ 5; 5; 5; 5; 5; 5; 5 ]; 

scrsz = get(0,'ScreenSize');
fracscr = 0.47;
figure('Position',[32 64 fracscr*scrsz(3) fracscr*scrsz(4)])
gscatter(x, y, group_byregion, colors, symbols, sizes, 'on', 'PET CBF/(mL/100g/min)', 'Bayesian <F>/(arbitrary)')
title(itsTitle, 'FontSize', 20)
cbfOsvd
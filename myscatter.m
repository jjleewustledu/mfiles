%MYSCATTER plots results from the rois_skeleton C# solution
%
%  SYNOPSIS:  myscatter(x, y)
%         x:  matlab array or dipimage object of abscissa data values
%         y:  matlab array or dipimage object of ordinate data values
%
%  SEE ALSO:  gscatter
%
% $Id$
%
function myscatter(x, y)

if (isa(x, 'dip_image')) x = double(x); end
if (isa(y, 'dip_image')) y = double(y); end
    
group_byside = [0 0 0 0 0 0 0 0 0 ...
                1 1 1 1 1 1 1 1 1 ...
                2 2 2 2 2 2 2 2 2 ...
                0 0 0 0 ...
                1 1 1 1 ...
                2 2 2 2]';
disp(['size of group_byside = ' num2str(size(group_byside))])
        
group_byregion = { 'brainstem'; 'caudate'; 'putamen'; 'thalamus'; 'callosum'; 'ACA'; 'MCA'; 'PCA'; 'parenchyma'; ...
                   'brainstem'; 'caudate'; 'putamen'; 'thalamus'; 'callosum'; 'ACA'; 'MCA'; 'PCA'; 'parenchyma'; ...
                   'brainstem'; 'caudate'; 'putamen'; 'thalamus'; 'callosum'; 'ACA'; 'MCA'; 'PCA'; 'parenchyma'; ...
                   'GREY'; 'WHITE'; 'BASAL GANGLIA'; 'PARENCHYMA'; ...
                   'GREY'; 'WHITE'; 'BASAL GANGLIA'; 'PARENCHYMA'; ...
                   'GREY'; 'WHITE'; 'BASAL GANGLIA'; 'PARENCHYMA' };
disp(['size of group_byregion = ' num2str(size(group_byregion))])
           
colors = { [0 0.2 0]     [1 0 0.7]     [1 0.3 0]     [1 0 0] [0.8 0.8 0] [0 0.9 0.9] [0 0.4 0.4] [0 0 0.4] [0 0 0] ...
           [0.5 0.5 0.5] [0.8 0.8 0] [0.8 0.8 0.5] [0 0 0] };
disp(['size of colors = ' num2str(size(colors))])

colors2 = 'brrrcbbbgkkkk';
disp(['size of colors2 = ' num2str(size(colors2))])

colors3 = 'rgb';
disp(['size of colors3 = ' num2str(size(colors3))])

symbols = 'oooooooooh*ds';
disp(['size of symbols = ' num2str(size(symbols))])

sizes = [15; 15; 15; 15; 15; 15; 15; 15; 15;  ...
         25; 25; 25; 25];
disp(['size of sizes = ' num2str(size(sizes))])

gscatter(x, y, group_byregion, colors2, symbols, sizes, 'on', 'PET CBF/(mL/100g/min)', 'MR CBF/arbitrary')
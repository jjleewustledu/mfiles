function [Q] = plot_colored_line(X,Y,C,varargin)

% -----------------------
%
% S. HSIANG 
% 5.11.2012
% SHSIANG@PRINCETON.EDU
%
% -----------------------
%
% PLOT_COLORED_LINE(X,Y,C) plots the line X vs. Y where the color of the
% segments are determed by values in C.  If no color is specified, then the
% line is plotted greyscale, with the lowest values set to [almost] white 
% and the highest values set to [almost] black.
%
% PLOT_COLORED_LINE(X,Y,C,V1) plots values scaled between almost white (low
% values) and the color specified by the three element vector V1 for high
% values.
%
% PLOT_COLORED_LINE(X,Y,C,V1,V0) plots values scaled between V0 (low
% values) and V1 (high values). Both V1 and V0 are three element vectors
% specifying a color (with entries between zero and one).  They can be 
% interchanged and the function will still plot, but the color scale will
% be reversed.
%
% PLOT_COLORED_LINE(X,Y,C,V1,V0,WIDTH) sets the line width to WIDTH
%
% Examples: 
%
%       x = [1:.1:100]
%       y = sin(x)
%       c = cos(x)
%       figure
%       plot_colored_line(x,y,y)
%       figure
%       plot_colored_line(x,y,c,[0 0 1], [1 0 0], 3)
%
%       r = randn(size(x))
%       figure
%       plot_colored_line(x,r,c)
%
% See also vwregress, plot_colored_fill



if length(X) ~= length(Y)
    disp('SOL: X and Y must be same length')
    Q = false;
    return
elseif length(X) ~= length(C)
    disp('SOL: X and C must be same length')
    Q = false;
    return
end

max_color = max(C);
min_color = min(C);
color_range = (max_color - min_color);

if min_color == max_color
    C = .5*ones(size(C));
else
    C = (C - min_color)/color_range;        %rescale color range
    %C = 1-(C*(length(C)-1)+.5)/length(C);   %prevent color from hitting extreme values
    C = ones(size(C))-C;                    %because low numbers are dark colors
end



%determine if colors are assigned
S = size(varargin);
linewidthvar = 1; %line width
if S(2) == 1
    %if top color vector is specified
    colorlimit = varargin{1,1};
    %bottom color is white
    colorbottom = [1 1 1];
elseif S(2) == 2
    %if top color vector is specified
    colorlimit = varargin{1};
    %bottom color is specified
    colorbottom = varargin{2};
elseif S(2) == 3
    %if top color vector is specified
    colorlimit = varargin{1};
    %bottom color is specified
    colorbottom = varargin{2}; 
    linewidthvar = varargin{3};
else
    colorlimit = [0 0 0]; %black for high values
    colorbottom = [1 1 1]; %whilte for low values
end



%plot each segment with color as the average value at both end points

for i = 1:length(X)-1
    plot(X(i:i+1),Y(i:i+1), 'Color', nanmean(C(i:i+1))*(colorbottom-colorlimit)+colorlimit, 'LineWidth',linewidthvar)
    
    if i == 1
        hold on
    end
end

Q = true;



    
        





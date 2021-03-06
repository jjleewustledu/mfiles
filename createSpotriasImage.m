function createSpotriasImage(cdata1)
%CREATEFIGURE(CDATA1)
%  CDATA1:  image cdata

%  Auto-generated by MATLAB on 21-Oct-2010 05:32:53

% Create figure
figure1 = figure('Tag','printImageToFigure','XVisual','','InvertHardcopy','off','Color',[1 1 1]);
colormap('jet');

% Create axes
axes1 = axes('Visible','off','Parent',figure1,'YDir','reverse','TickDir','out','Position',[0 0 1 1],...
    'Layer','top',...
    'FontSize',14,...
    'DataAspectRatio',[1 1 1],...
    'CLim',[0 1002.51831501832]);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0.5 208.5]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0.5 256.5]);
% Uncomment the following line to preserve the Z-limits of the axes
% zlim(axes1,[0 1]);
box(axes1,'on');
hold(axes1,'all');

% Create image
image(cdata1,'Parent',axes1,'CDataMapping','scaled');

% Create colorbar
colorbar('peer',axes1,[0.380952380952381 0.907817109144543 0.241269841269841 0.0737463126843658],...
    'YColor',[1 1 1],...
    'XColor',[1 1 1],...
    'LineWidth',1,...
    'FontSize',14);

% Create textbox
annotation(figure1,'textbox',[0.406291005291006 -0.056047197640118 0.181010582010582 0.176991150442478],...
    'String',{'oc1 (counts), z=93'},...
    'FontSize',14,...
    'FitBoxToText','off',...
    'EdgeColor','none',...
    'Color',[1 1 1]);


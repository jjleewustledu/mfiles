function createfigure(X1, Y1, XData1, YData1, YData2, XData2, YData3)
%CREATEFIGURE(X1,Y1,XDATA1,YDATA1,YDATA2,XDATA2,YDATA3)
%  X1:  vector of x data
%  Y1:  vector of y data
%  XDATA1:  line xdata
%  YDATA1:  line ydata
%  YDATA2:  line ydata
%  XDATA2:  line xdata
%  YDATA3:  line ydata

%  Auto-generated by MATLAB on 05-Jun-2011 01:18:47

% Create figure
figure1 = figure('XVisual','','Name','p7219','IntegerHandle','off');

% Create axes
axes1 = axes('Parent',figure1,'Position',[0.13 0.11 0.775 0.815],'FontSize',16,'FontAngle','italic');
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 60]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 60]);
box(axes1,'on');
hold(axes1,'all');

% Create plot
plot(X1,Y1,'Parent',axes1,'LineWidth',2,'Color',[0.313725501298904 0.313725501298904 0.313725501298904],...
    'DisplayName','linear regression');

% Create line
line(XData1,YData1,'Parent',axes1,'LineWidth',2,'LineStyle',':','Color',[0.313725501298904 0.313725501298904 0.313725501298904],...
    'DisplayName','95% prediction bounds');

% Create line
line(XData1,YData2,'Parent',axes1,'LineWidth',2,'LineStyle',':','Color',[0.313725501298904 0.313725501298904 0.313725501298904]);

% Create line
line(XData2,YData3,'Parent',axes1,'MarkerFaceColor',[0 0 0],'MarkerEdgeColor',[0 0 0],'MarkerSize',10,'Marker','+',...
    'LineStyle','none',...
    'DisplayName','mean, SEM of ROIs');

% Create ylabel
ylabel('Bookends MR CBF / (mL/min/100 g)','FontWeight','bold','FontSize',20);

% Create xlabel
xlabel('Perm.-corrected PET CBF / (mL/min/100 g)','FontWeight','bold','FontSize',20);

% Create title
title('p7219 right hemisphere','Interpreter','none','FontWeight','bold','FontSize',20);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Interpreter','none','EdgeColor',[1 1 1],'YColor',[1 1 1],'XColor',[1 1 1],...
    'Position',[0.167972567811112 0.725959830453792 0.290680785821348 0.127554904018788],...
    'FontSize',14);


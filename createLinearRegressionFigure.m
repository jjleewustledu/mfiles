function createLinearRegressionFigure(X1, Y1, X2, YMatrix1)
%CREATEFIGURE(X1, Y1, X2, YMATRIX1)
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 26-Nov-2013 17:32:01

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'FontSize',14);
box(axes1,'on');
hold(axes1,'all');

% Create plot
plot(X1,Y1,'Parent',axes1,'MarkerFaceColor',[0.24705882370472 0.24705882370472 0.24705882370472],'Marker','square','LineStyle','none',...
    'DisplayName','Data',...
    'Color',[0 0 0]);

% Create multiple lines using matrix input to plot
plot1 = plot(X2,YMatrix1,'Parent',axes1,'Color',[1 0 0],'LineStyle',':');
set(plot1(1),'DisplayName','Fit','LineStyle','-');
set(plot1(2),'DisplayName','Confidence bounds');

% Create xlabel
xlabel('Cortical Thickness/mm','Interpreter','none','FontWeight','bold','FontSize',16);

% Create ylabel
ylabel('t0/s','Interpreter','none','FontWeight','bold','FontSize',16);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Location','NorthEastOutside');

% Create textbox
annotation(figure1,'textbox',[0.731729701952723 0.426367461430575 0.260048304213772 0.384291725105189],...
    'String',{'R-squared: 0.219','Adjusted R-Squared 0.207','F-statistic vs. constant model: 18.5','p-value = 5.82e-05'},...
    'FontSize',14,...
    'FitBoxToText','off',...
    'LineStyle','none');


function [rightStr,leftStr] = createFit(paxis,eaxis)
%% CREATEFIT Create plot of data sets and fits
%  Usage:  [rightStr,leftStr] = createFit(paxis,eaxis)
%           ^        ^ struct:  cf, gof, out
%
%   Creates a plot, similar to the plot in the main Curve Fitting Tool,
%   using the data that you provide as input.  You can
%   use this function with the same data you used with CFTOOL
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of data sets:  3
%   Number of fits:  2

% Data from data set "eaxis vs. paxis":
%     X = paxis:
%     Y = eaxis:
%     Unweighted

% Data from data set "eaxisL vs. paxisL":
%     X = paxisL:
%     Y = eaxisL:
%     Unweighted

% Data from data set "eaxisR vs. paxisR":
%     X = paxisR:
%     Y = eaxisR:
%     Unweighted

% Auto-generated by MATLAB on 05-Jun-2011 01:49:58

import mlfsl.*;
[paxisR,paxisL] = FnirtBuilder.splitAxis(paxis);
[eaxisR,eaxisL] = FnirtBuilder.splitAxis(eaxis);




% Set up figure to receive data sets and fits
f_ = clf;
figure(f_);
set(f_,'Units','Pixels','Position',[294 309 672 481]);
% Line handles and text for the legend.
legh_ = [];
legt_ = {};
% Limits of the x-axis.
xlim_ = [Inf -Inf];
% Axes for the plot.
ax_ = axes;
set(ax_,'Units','normalized','OuterPosition',[0 0 1 1]);
set(ax_,'Box','on');
axes(ax_);
hold on;

% --- Plot data that was originally in data set "eaxis vs. paxis"
paxis = paxis(:);
eaxis = eaxis(:);
% This data set does not appear on the plot. To add it to the plot, uncomment
% the following lines and select the desired color and marker.
%    h_ = line(paxis,eaxis,'Color','r','Marker','.','LineStyle','none');
%    xlim_(1) = min(xlim_(1),min(paxis));
%    xlim_(2) = max(xlim_(2),max(paxis));
%    legh_(end+1) = h_;
%    legt_{end+1} = 'eaxis vs. paxis';

% --- Plot data that was originally in data set "eaxisL vs. paxisL"
paxisL = paxisL(:);
eaxisL = eaxisL(:);
h_ = line(paxisL,eaxisL,'Parent',ax_,'Color',[0.333333 0.666667 0],...
    'LineStyle','none', 'LineWidth',1,...
    'Marker','o', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(paxisL));
xlim_(2) = max(xlim_(2),max(paxisL));
legh_(end+1) = h_;
legt_{end+1} = 'eaxisL vs. paxisL';

% --- Plot data that was originally in data set "eaxisR vs. paxisR"
paxisR = paxisR(:);
eaxisR = eaxisR(:);
h_ = line(paxisR,eaxisR,'Parent',ax_,'Color',[0 0 0],...
    'LineStyle','none', 'LineWidth',1,...
    'Marker','s', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(paxisR));
xlim_(2) = max(xlim_(2),max(paxisR));
legh_(end+1) = h_;
legt_{end+1} = 'eaxisR vs. paxisR';

% Nudge axis limits beyond data limits
if all(isfinite(xlim_))
    xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
    set(ax_,'XLim',xlim_)
else
    set(ax_, 'XLim',[0, 80]);
end

% --- Create fit "fitRight"
ok_ = isfinite(paxisR) & isfinite(eaxisR);
if ~all( ok_ )
    warning( 'GenerateMFile:IgnoringNansAndInfs',...
        'Ignoring NaNs and Infs in data.' );
end
ft_ = fittype('poly1');

% Fit this model using new data
[cfR,gofR,outR] = fit(paxisR(ok_),eaxisR(ok_),ft_); cf_ = cfR;
% Alternatively uncomment the following lines to use coefficients from the
% original fit. You can use this choice to plot the original fit against new
% data.
%    cv_ = { 0.46869377855348565154, 13.660928269636775312};
%    cf_ = cfit(ft_,cv_{:});

% Plot this fit
h_ = plot(cf_,'fit',0.95);
set(h_(1),'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
% Turn off legend created by plot method.
legend off;
% Store line handle and fit name for legend.
legh_(end+1) = h_(1);
legt_{end+1} = 'fitRight';

% --- Create fit "fitLeft"
ok_ = isfinite(paxisL) & isfinite(eaxisL);
if ~all( ok_ )
    warning( 'GenerateMFile:IgnoringNansAndInfs',...
        'Ignoring NaNs and Infs in data.' );
end
ft_ = fittype('poly1');

% Fit this model using new data
[cfL,gofL,outL] = fit(paxisL(ok_),eaxisL(ok_),ft_); cf_ = cfL;
% Alternatively uncomment the following lines to use coefficients from the
% original fit. You can use this choice to plot the original fit against new
% data.
%    cv_ = { 0.8722622694476358518, -0.85149792215106279158};
%    cf_ = cfit(ft_,cv_{:});

% Plot this fit
h_ = plot(cf_,'fit',0.95);
set(h_(1),'Color',[0 0 1],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
% Turn off legend created by plot method.
legend off;
% Store line handle and fit name for legend.
legh_(end+1) = h_(1);
legt_{end+1} = 'fitLeft';

% --- Finished fitting and plotting data. Clean up.
hold off;
% Display legend
leginfo_ = {'Orientation', 'vertical'};
h_ = legend(ax_,legh_,legt_,leginfo_{:});
set(h_,'Units','normalized');
t_ = get(h_,'Position');
t_(1:2) = [0.168058,0.773304];
set(h_,'Interpreter','none','Position',t_);
% Remove labels from x- and y-axes.
xlabel(ax_,'');
ylabel(ax_,'');

% --- Format output
rightStr = struct('cf',cfR,'gof',gofR,'out',outR,'paxis',paxisR,'eaxis',eaxisR);
 leftStr = struct('cf',cfL,'gof',gofL,'out',outL,'paxis',paxisL,'eaxis',eaxisL);

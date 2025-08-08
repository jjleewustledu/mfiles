function bland_altman_plots(M1, M2, viridis_colors, opts)
% BLAND_ALTMAN_PLOTS Generate scatter and Bland-Altman residual plots
%
% Inputs:
%   M1 - First measurement matrix (Nregions x Nsub)
%   M2 - Second measurement matrix (Nregions x Nsub)
%   viridis_colors - Colormap matrix from viridis(Nsub)
%   opts.plot_title - Title string, can contain LaTeX math
%
% Example usage:
%   M1 = randn(100, 5) + 10;  % Example data
%   M2 = M1 + 0.5*randn(100, 5) + 0.2;  % Correlated with noise
%   colors = viridis(5);
%   bland_altman_plots(M1, M2, colors);
%   bland_altman_plots(M1, M2, colors, 'Analysis of $\alpha$ vs $\beta

arguments
    M1 {mustBeNumeric}
    M2 {mustBeNumeric}
    viridis_colors {mustBeNumeric} = viridis(5)
    opts.plot_title {mustBeTextScalar} = 'Bland--Altman Analysis'
end

subjects = "EVA" + [109, 112, 114, 115, 118];
subjects = convertStringsToChars(subjects);

[Nregions, Nsub] = size(M1);

% Validate inputs
if ~isequal(size(M1), size(M2))
    error('M1 and M2 must have the same dimensions');
end

if size(viridis_colors, 1) ~= Nsub
    error('Number of colors must match number of subjects (Nsub)');
end

% Calculate residuals and unbiased estimators
R = M1 - M2;  % Residual matrix
E = mean(cat(3, M1, M2), 3);  % Unbiased estimator (mean along 3rd dimension)

% Calculate 95% confidence intervals for residuals
all_residuals = R(:);  % Flatten all residuals
mean_residual = mean(all_residuals, "omitnan");
std_residual = std(all_residuals, "omitnan");
ci_upper = mean_residual + 1.96 * std_residual;
ci_lower = mean_residual - 1.96 * std_residual;

%% Plot 1: Scatter plot with line of unity
figure('Position', [100, 100, 800, 600]);
subplot(1, 2, 1);
hold on;

% Plot data for each subject with distinct colors
for isub = 1:Nsub
    scatter(M1(:, isub), M2(:, isub), 50, viridis_colors(isub, :), 'filled', ...
            'MarkerEdgeColor','k', 'MarkerEdgeAlpha', 0.388, 'LineWidth', 0.5, 'MarkerFaceAlpha', 0.388);
end

% Add line of unity
xlims = xlim;
ylims = ylim;
plot_lims = [min(xlims(1), ylims(1)), max(xlims(2), ylims(2))];
plot(plot_lims, plot_lims, 'k--', 'LineWidth', 2);

% Formatting
xlabel('PET1', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('PET2', 'FontSize', 12, 'FontWeight', 'bold');
% title('Scatter Plot: M1 vs M2', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
axis equal;
xlim(plot_lims);
ylim(plot_lims);

% Add legend
legend_entries = cell(Nsub + 1, 1);
sidx = 0;
for isub = subjects
    sidx = sidx + 1;
    legend_entries{sidx} = isub{1};
end
legend_entries{end} = 'Line of Unity';
legend(legend_entries, 'Location', 'best', 'FontSize', 10);

%% Plot 2: Bland-Altman residual plot
subplot(1, 2, 2);
hold on;

% Plot residuals for each subject with distinct colors
for isub = 1:Nsub
    scatter(E(:, isub), R(:, isub), 50, viridis_colors(isub, :), 'filled', ...
            'MarkerEdgeColor','k', 'MarkerEdgeAlpha', 0.388, 'LineWidth', 0.5, 'MarkerFaceAlpha', 0.388);
end

% Add confidence interval lines
x_range = xlim;
plot([x_range(1), x_range(2)], [mean_residual, mean_residual], 'k-', 'LineWidth', 2);
plot([x_range(1), x_range(2)], [ci_upper, ci_upper], 'k:', 'LineWidth', 2);
plot([x_range(1), x_range(2)], [ci_lower, ci_lower], 'k:', 'LineWidth', 2);

% Formatting
xlabel('Unbiased Estimator: (PET1 + PET2)/2', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Residuals: PET1 - PET2', 'FontSize', 12, 'FontWeight', 'bold');
% title('Bland-Altman Plot: Residuals vs Mean', 'FontSize', 14, 'FontWeight', 'bold');
grid on;

% Add legend for residual plot
legend_entries_residual = cell(Nsub + 3, 1);
sidx = 0;
for isub = subjects
    sidx = sidx + 1;
    legend_entries_residual{sidx} = isub{1};
end
legend_entries_residual{end-2} = 'Mean Residual';
legend_entries_residual{end-1} = '+1.96 SD';
legend_entries_residual{end} = '-1.96 SD';
legend(legend_entries_residual, 'Location', 'best', 'FontSize', 10);

% Add text annotations for CI values
text(0.02, 0.98, sprintf('Mean: %.3f', mean_residual), 'Units', 'normalized', ...
     'VerticalAlignment', 'top', 'FontSize', 10, 'BackgroundColor', 'white');
text(0.02, 0.93, sprintf('95%% CI: [%.3f, %.3f]', ci_lower, ci_upper), ...
     'Units', 'normalized', 'VerticalAlignment', 'top', 'FontSize', 10, ...
     'BackgroundColor', 'white');

hold off;

% Adjust subplot spacing
sgtitle(opts.plot_title, 'FontSize', 16, 'FontWeight', 'bold', 'Interpreter', 'latex');


end

%% Example usage and test
% Uncomment the following lines to test the function:

% % Generate example data
% Nregions = 100;
% Nsub = 5;
% 
% % Create correlated measurement matrices with some noise
% M1 = 10 + 5*randn(Nregions, Nsub);
% M2 = M1 + 0.3*randn(Nregions, Nsub) + 0.5;  % Systematic bias + noise
% 
% % Generate viridis colormap
% colors = viridis(Nsub);
% 
% % Create the plots
% bland_altman_plots(M1, M2, colors);
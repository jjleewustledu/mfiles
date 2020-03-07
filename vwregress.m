function [Q, handle] = vwregress(X, Y, bins, bandwidth, varargin)

%----------------------
%SOLOMON HSIANG
%SHSIANG@PRINCETON.EDU
%MAY 2012
%----------------------
%
%[Q, handle] = vwregress(X, Y, BINS, BANDWIDTH)
%
%version 1.3
%
%VWREGRESS estimates a non-parametric regression (Nadaraya-Watson) and
%plots it "visually weighted" based on the observational density of the
%underlying data.  Specifically, the darkness of the line is inversely
%propotional to the expected variance in the regression line [sqrt(obs)].
%The visual weighting is set to approach almost zero for the bin with the
%smallest density of observations. 
%
%For complete details on the regression model, type 'help NWbootstrap_epkv'
%
%OPTIONAL ARGUMENTS:
%   RESAMPLES   - integer scaler
%   COLORVECTOR - three element colorvector
%   'HIST'      - string
%   'OLS'       - string
%   'SCATTER'   - string
%   'SOLID'     - string
%   'CI'        - string
%   'SPAG'      - string
%   'FILL'      - string
%   'SMOOTH'    - string
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, RESAMPLES) plots confidence 95% intervals
%that are bootstrapped using the specified number of resamples (a scaler). 
%The CI are visually weighted using the same scheme as the main regression 
%line. If 'SPAG' or 'FILL' options are specified, then they use the
%RESAMPLES to determine the number of resamples used in their bootstrap but
%the normal confidence interval limits are not displayed.
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, COLORVECTOR) plots the maximum color (and
%CI or OLS if specified) as the color specified by the three-element vector
%COLORVECTOR (eg [0 .3 .9]).
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, 'HIST') plots a second panel under the
%main regression displaying a histogram of the underlying data.
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, 'OLS') plots the ordinarly least squares
%fit to the data as a thin line.
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, 'SCATTER') plots the scatterplot of the
%raw data.
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, 'SOLID') plots the regression line as a
%single color so there is no visual weighting.
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, 'FILL') resamples the data 100 times
%(or RESAMPLES times, if that is specified) and fills the confidence
%intervals with COLORVECTOR that has been visually weighted (and slightly
%down-weighted relative to the conditional mean. [If 'FILL' is specified
%with 'SOLID', then only the conditional mean is solid and the confidence
%interval remains visually weighted.]
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, 'SPAG') resamples the data 100 times
%(or RESAMPLES times, if that is specified) and plots all the resampled
%estimates as a spaghetti plot using COLORVECTOR that has been visually 
%weighted (and slightly down-weighted relative to the conditional mean. 
%[If 'SPAG' is specified with 'SOLID', then both the conditional mean and
%the spaghetti plot are solid.] WARNING: the "SPAG' option slows down the
%plotting time substantially if it is not combined with the 'SOLID' option.
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, 'SMOOTH') resamples the data 100 times
%(or RESAMPLES times, if that is specified) and then computes the estimated
%density of resampled estimates at every bin in X. The resulting plot has
%higher color saturation to reflect a higher density of estimates. The
%visual-weighting scheme also "conserves ink" in the sense that vertical
%line integrals of the probability mass are always equal to one. The mean
%regression line is plotted as white, so the visual contrast is highest 
%where the statistical confidence is also highest.
%
%VWREGRESS(X, Y, BINS, BANDWIDTH, 'CI') resamples the data 100 times
%(or RESAMPLES times, if that is specified) and colors the regression line
%according one over the width of the confidence interval (higher
%confidence is darker). When combined with the 'FILL' options, this plot
%"conserves ink" for any vertical sliver (dx) of the colored CI band. 
%
%Options RESAMPLES, COLORVECTOR, 'HIST', 'OLS', 'SCATTER', 'SOLID', 'FILL' 
%'SPAG', 'SMOOTH', and 'CI' can be combined and reordered.
%
%The output Q is an array that is 2 by BINS (or 4 by bins if RESAMPLES is 
%specified).  The first row is the values of x for each bin, the second row
%is the estimated conditional mean y(x) for that bin. If RESAMPLES is
%specified, then the third and fourth rows are the bounds of the 95%
%confidence interval CI_max(x) and CI_min(x) for each bin.
%
%If output HANDLE is specified, it returns the handle to the figure plotted.
%
%Requires functions 
%       DROP_MISSING_Y.m
%       PLOT_COLORED_LINE.m
%       PLOT_COLORED_FILL.m
%
%See also NWbootstrap_epkv, NWbootstrap_epkv_3D, NWbootstrap,
%boxplot_regression
%
%--------------------------------------------------------------------------
%
%WHEN USING THIS CODE, PLEASE CITE: 
%
%   Hsiang, S.M. (2012) "Visually-weighted regression", working paper
%
%--------------------------------------------------------------------------
%
%RECOMMENDED VALUES (approx):
%
%BINS < n/10 (more bins will slow the bootstrap if RESAMPLES is specified)
%
%BANDWIDTH < (max(X) - min(X))/8
%BANDWIDTH > (max(X) - min(X))/(2*BINS)
%
%
%RESAMPLES > 100, if you have time, = 10,000
%
%----------------------
%
%EXAMPLE:
%
%     x = randn(100,1);
%     e = randn(100,1);
%     y = 2*x+x.^2+4*e;
% 
%     vwregress(x, y, 30, 1);
%     vwregress(x, y, 30, 1, 200);
%     vwregress(x, y, 30, 1, 'SOLID', [1 0 0]);
%     vwregress(x, y, 30, 1, 'HIST');
%     vwregress(x, y, 30, 1, 'SCATTER','OLS','CI',[0 .5 .5]);
%     vwregress(x, y, 300, 1,'SPAG');
%     vwregress(x, y, 300, 1,'FILL');
%     vwregress(x, y, 300, 1,'SMOOTH');
%
%----------------------

%-------------------------------------------------------------------------|
%ALTER THESE PARAMETERS TO ADJUST THE LOOK OF OUTPUT FIGURES:
%-------------------------------------------------------------------------|
%DEFAULT = 95% CI, CHANGE THIS NUMBER TO ALTER WIDTH OF CI WHEN
%BOOTSTRAPPING OPTIONS ARE SELECTED   
alpha = 0.05; 

%CHANGE THIS NUMBER TO ALTER THE VISUAL DOWN-WEIGHTING OF THE CI FILL
%(RELATIVE TO THE REGRESSION LINE) WHEN THE OPTION 'FILL' IS SELECTED. THE
%FILLED CI WILL BE PLOTTED USING THE SAME VISUAL WEIGHTING SCHEME, BUT THE
%MAXIMUM COLORATION WILL BE COLORVECTOR*FILL_INTENSITY.
fill_intensity = 1;  %set to values between zero and one

%SAME, BUT FOR SPAGETTI PLOT COLOR INTENSITY
spag_intensity = 0.75;  %set to values between zero and one

%SAME, BUT FOR SMOOTH PLOT COLOR INTENSITY
smooth_intensity = 1;  %set to values between zero and one

%SAME, BUT FOR OLS PLOT COLOR INTENSITY
OLS_intensity = 0.75;   %set to values between zero and one

%SAME, BUT FOR SCATTER PLOT COLOR INTENSITY
SCATTER_intensity = 0.75;   %set to values between zero and one

%-------------------------------------------------------------------------|



%---------------------------------------reshaping X and Y and removing NaNs

S = size(X);
S2 = size(Y);
X = reshape(X,S(1)*S(2),1);
Y = reshape(Y,S2(1)*S2(2),1);

if length(Y) ~= length(X)
    disp('SOL: X AND Y MUST BE THE SAME SIZE')
    Q = nan(1);
    return
end

[Y, X] = drop_missing_Y(Y, X);

%---------------------------checking that bandwidth selection is reasonable

if bandwidth*2<(max(X)-min(X))/bins
    disp('WARNING (SOL): BANDWIDTH IS TOO SMALL FOR THE NUMBER OF BINS CHOSEN')
    disp('(INFORMATION MAY BE LOST DUE TO SPARSE SAMPLING)')
end

if bandwidth*2>(max(X)-min(X))
    disp('WARNING (SOL): BANDWIDTH IS SO LARGE THAT INFORMATION IS CARRIED TOO FAR')
    disp('(INFORMATION IS CARRIED ACROSS THE ENTIRE DOMAIN FOR EACH OBSERVATION)')
end

colorvector = [0 0 0]; %black is default


%----estimating the conditional mean with Nadaraya-Watson kernal regression

N=size(X);
h = bandwidth;
Nbins = bins;
xlow = min(X); xhigh = max(X);
range = xhigh-xlow;
bin_range = range/Nbins;
binsX = xlow+bin_range/2:bin_range:xhigh-bin_range/2;
binsY = nan(size(binsX));
binsW = nan(size(binsX));
for i = 1:Nbins
    dists_h = (X-binsX(i)*ones(size(X)))/h;
    weights = 3/4*(1-dists_h.^2).*(abs(dists_h)<=1);
    binsY(i) = (weights'*Y)/sum(weights);
    binsW(i) = sum(weights);
end

%--------------------------------------------------------- parsing options

%additional plot elements
HIST = false;
OLS = false;
SCATTER = false;
SOLID = false;


%elements related to boostrapped standard errors
CI_WEIGHTS = false;     %use CI width as visual weights
CI_plot = false;        %plot CI with lines (visually weighted as default)
BOOTSTRAP = false;      %compute boostrapped CIs
CI_fill = false;        %plot CI as filled space (visually weighted)
CI_spag = false;        %plot all boostrapped estimates
SMOOTH = false;         %plot smoothed spaghetti plot
Nsamples = 0;


S = size(varargin);

if S(2) > 0
    for s = 1:S(2)
        if ischar(varargin{s})
            if strcmp(varargin{s}, 'HIST')
                HIST = true;
            elseif strcmp(varargin{s}, 'OLS')
                OLS = true;
            elseif strcmp(varargin{s}, 'SCATTER')
                SCATTER = true;
            elseif strcmp(varargin{s}, 'SOLID')
                SOLID = true;
            elseif strcmp(varargin{s}, 'FILL')
                CI_fill = true;
                BOOTSTRAP = true;
            elseif strcmp(varargin{s}, 'SPAG')
                CI_spag = true;
                BOOTSTRAP = true;
            elseif strcmp(varargin{s}, 'SMOOTH')
                SMOOTH = true;    
                BOOTSTRAP = true;
            elseif strcmp(varargin{s}, 'CI')
                CI_WEIGHTS = true;
                BOOTSTRAP = true;    
            end
        elseif isnumeric(varargin{s})
            if length(varargin{s}) == 1
                BOOTSTRAP = true;
                CI_plot = true;
                Nsamples = varargin{s};
            elseif length(varargin{s}) == 3
                colorvector = varargin{s};
            end
        end
    end
end

%set standard color to be maximum color of conditional mean
mean_colorvector = colorvector; 

%line width of 2 is default
linewidthscalar = 2; 

%use reverse coloration and thin line for the conditional mean in these
%these cases
if SMOOTH == true || CI_fill == true
    mean_colorvector = [1 1 1];
    linewidthscalar = 1;
end

if SOLID == true
    mean_colorvector = colorvector;
end

%in case not resample count is specified for boostrapping options
if BOOTSTRAP == true && Nsamples == 0
    Nsamples = 100;
end

if SOLID == true && CI_WEIGHTS == true
    disp('SOL: both SOLID and CI are specified, override CI');
end

%supress simple plot of CI limits if FILL or SPAG is specified
if CI_fill == true
    CI_plot = false;
end

if CI_spag == true
    CI_plot = false;
end

%supress all other standard error plot commands if SMOOTH specified
if SMOOTH == true
    CI_plot = false;
    CI_spag = false;
    CI_fill = false;
end


%------------------------- bootstraping CI if number of resamples specified

CI = nan; %returns nothing if CI option not true.

if BOOTSTRAP == true
    waitmessage = ['bootstrapping ' num2str(Nsamples) ' times'];
    H = waitbar(0,waitmessage);
    
    resamples = nan(Nsamples, Nbins);
    for j = 1:Nsamples
        rs = ceil(rand(length(X),1)*length(X));
        X_rs = X(rs);
        Y_rs = Y(rs);
        waitbar(j/Nsamples,H);
        for i = 1:Nbins
            dists_h = (X_rs-binsX(i)*ones(N))/h;
            weights = 3/4*(1-dists_h.^2).*(abs(dists_h)<=1);
            resamples(j,i) = (weights'*Y_rs)/sum(weights);
        end
    end
    
    close(H)

    sorted_samples = sort(resamples);
    CI = [sorted_samples(round((1-alpha/2)*Nsamples),:);sorted_samples(round(alpha/2*Nsamples),:)];
end

%change this line to alter the weighting scheme for visual weighting------|
binsW = binsW.^.5;  %set color to be the inverse of the variance
%binsW = binsW;      %set color to be the observational density

%use width of confidence intervals as weighting scheme if CI is specified
if CI_WEIGHTS == true 
    binsW = 1./abs(diff(CI,1)); 
    %binsW = -abs(diff(CI,1)); %alternative weighting scheme

    %to prevent NaNs from crashing the colored line function
    for i=1:length(binsW)
        if isnan(binsW(i))
            binsW(i) = min(binsW);
        end
    end
end
%-------------------------------------------------------------------------|




%----------------- computing smooth estimate density if option is specified

if SMOOTH ==  true

    %the approach here is to define a new coordinate system in Y here
    %(called "grids") that correspond to the xvalues in binsX. The grids
    %span the range of bootstrapped estimates and break that range up into
    %bins (Vbins = Nbins = BINS). The bootstapped "spaghetti" plot is then
    %transformed into a smooth kernel density (over Y) within each x-bin. 
    %If many bootstrapped estimates fall in a bin, it has a high
    %probability and the color saturation is heightened to reflect that.
    %This is repeated for each x-bin so that the entire range of
    %bootstrapped estimates is made into a smooth joint distribution in X
    %and Y.
    
    %The mean regression line is here plotted as white so that it strongly
    %contrasts with a background of high density (confident) bootstrapped 
    %estimates. If the background is diffuse, it will be close to white and
    %the conditional mean will not contrast well. This will lower its
    %visual weight.
    
    %The visual weighting scheme of the estimated distribution is designed
    %to have "fixed ink" for each x-bin. The vertical integrated amount of
    %color should be constant for a vertical line integral.
    
    Vbins = bins; %use same number of bins in vertical as used in horizontal
    Vgrids = nan(Vbins,Nbins); %verticies for smoothing grid
    Vmasses = nan(Vbins,Nbins);  %number of bootstrapped estimates at each vertex
    V_hs = nan(1,Nbins); % store the bandwidth for each vertical grid
    Vranges = nan(1,Nbins); %store the grid scale size for each vertical grid
    
    for j = 1:Nbins
        
        %vertical range for each bin
        ylow = min(sorted_samples(:,j));
        yhigh = max(sorted_samples(:,j));
        range = yhigh-ylow;
        
        V_h = range/10; %set bandwidth to be 1/10 of range 
        
        Vgrid_range = range/Vbins;
        
        %bin specific vertical grid 
        grid = [ylow+Vgrid_range/2:Vgrid_range:yhigh-Vgrid_range/2]';        
        gbins = length(grid);
        %mass (of boostrapped estimates) at each grid point in the bin
        mass = nan(size(grid));
        
        %compute kernel density along the vertical grid
        for i = 1:gbins
            
            dists_h = (sorted_samples(:,j)-grid(i)*ones(size(sorted_samples(:,j))))/V_h;
                        
            weights = 3/4*(1-dists_h.^2).*(abs(dists_h)<=1);
            
            mass(i) = nansum(weights);
        
        end
        
        Vgrids(1:gbins,j) = grid;
        Vmasses(1:gbins,j) = mass';
        V_hs(j) = V_h;
        Vranges(j) = Vgrid_range;
        
    end
    
    %scale mass by 1/Vgrid_range since narrower grid means more mass in 
    %each grid cell
    
    Vmasses_scaled = Vmasses.*repmat(1./Vranges,Vbins,1);
    
    %to prevent NaNs from crashing the plot_colored_fill function
    for i=1:Nbins
        for j = 1:Vbins
            if isnan(Vmasses_scaled(i,j))
                Vmasses_scaled(i,j) = nanmin(nanmin(Vmasses_scaled,[],1),[],2);
            end
        end
    end
    
    %because the plot_colored_fill function scales each grid row to the max
    %of that row, need a vector to store the densities of the max in each
    %row:
    max_Vmass2 = nanmax(Vmasses_scaled,[],2);
    max_Vmass = max_Vmass2/nanmax(max_Vmass2); %rescale to have a max of one
    
    %weaken the fill color relative to the regression line color
    smooth_colorvector = [1 1 1]-([1 1 1]-colorvector)*smooth_intensity;

    for i = 1:Vbins-1
        %scale the color of each grid row relative to the max in that row
        Vgrid_row_colorvector = [1 1 1]-([1 1 1]-smooth_colorvector)*max_Vmass(i);
        
        plot_colored_fill(binsX,Vgrids(i,:),Vgrids(i+1,:), ...
            mean(Vmasses_scaled(i:i+1,:),1),Vgrid_row_colorvector, [1 1 1]); 
    end
    
    
%     %section to plot out the moving grid system used to smooth the
%     %resampled estimates (illustrative only)
%     for i = 1:Vbins
%         plot(binsX,Vgrids(i,:),'Color', [1 1 1]*.1, 'LineWidth', .05)
%     end
%     for j = 1:Nbins
%         plot([binsX(j), binsX(j)], [Vgrids(1,j), Vgrids(end,j)], 'Color', [1 1 1]*.1, 'LineWidth', .05)
%     end
    
    
end %SMOOTH option section

%-------------------------------------------------------------------------|




%----------------------------------------------------------Plotting results

%make two plots if HIST option specified, plot histogram first
if HIST == true 
    %figure %make new fig if HIST options specified
    subplot(2,1,2)
    hist(X,binsX); 
    j = findobj(gca,'Type','patch');
    set(j,'FaceColor','w','EdgeColor','k')
%   set(j,'FaceColor',[.8 .8 .8],'EdgeColor','w') %alternative color scheme
    ylabel('Observations')
    xlabel('X')
    box off
    subplot(2,1,1)
end

%plot filled and visually-weighted CI if FILL is specified
if CI_fill == true
    
    %weaken the fill color relative to the regression line color
    fill_colorvector = [1 1 1]-([1 1 1]-colorvector)*fill_intensity;
    
    %plotted the filled CIs
    plot_colored_fill(binsX,CI(1,:),CI(2,:),binsW, fill_colorvector, [1 1 1])
end


%plot all boostrapped estimates (spagetti plot) if SPAG is specified
if CI_spag == true
    %weaken the spagetti color relative to the regression line color
    spag_colorvector = [1 1 1]-([1 1 1]-colorvector)*spag_intensity;
        
    if SOLID == true
        %plot spagetti plot without visual weighting (line width = .25)
        for i = 1:Nsamples
            plot(binsX,resamples(i,:),'Color', spag_colorvector, 'LineWidth', .25);
            if i == 1
                hold on
            end
        end
    else
        %plot spagetti plot with visual weighting (line width = .25)
        for i = 1:Nsamples
            plot_colored_line(binsX,resamples(i,:),binsW, spag_colorvector, [1 1 1], .25);
            if i == 1
                hold on
            end
        end
    end
end


%plot conditional mean as single color if SOLID is specified, otherwise plot
%it as a visually weighted line (default)


if SOLID == true || SMOOTH == true
%    handle = plot_colored_line(binsX,binsY,binsW, mean_colorvector, mean_colorvector, linewidthscalar);
    handle = plot(binsX,binsY,'Color', mean_colorvector, 'LineWidth', linewidthscalar);
else
    handle = plot_colored_line(binsX,binsY,binsW, mean_colorvector, [1 1 1], linewidthscalar);
end


%plot boostrapped CI if RESAMPLES is specified without FILL or SPAG options
if CI_plot == true
    if SOLID == true
        plot_colored_line(binsX,CI(1,:),binsW, colorvector, colorvector, .5)
        plot_colored_line(binsX,CI(2,:),binsW, colorvector, colorvector, .5)
    else
        plot_colored_line(binsX,CI(1,:),binsW, colorvector, [1 1 1], .5)
        plot_colored_line(binsX,CI(2,:),binsW, colorvector, [1 1 1], .5)
    end
end



%plot regression line if OLS is specified
if OLS == true
    
    %weaken the OLS color relative to the regression line color
    OLS_colorvector = [1 1 1]-([1 1 1]-colorvector)*OLS_intensity;
        
    P = polyfit(X,Y,1);
    OLS_fit = polyval(P,binsX);
    plot(binsX,OLS_fit,'Color',OLS_colorvector,'LineWidth', .25)
end

%plot scatter overlaid if SCATTER is specified
if SCATTER == true
    
    %weaken the scatter color relative to the regression line color
    SC_colorvector = [1 1 1]-([1 1 1]-colorvector)*SCATTER_intensity;
    
    plot(X,Y,'.','Color',SC_colorvector)
end


%label the plot
xlabel('X')
ylabel('Y')
box off
hold on

title(['Epanechnikov bwidth = ' num2str(h)]);
if CI_plot == true || CI_fill == true
    titlestring = ['Epanechnikov bwidth = ' num2str(bandwidth) ', ' num2str((1-alpha)*100) '% C.I. [' num2str(Nsamples) ' resamples]'];
    title(titlestring);
end
if CI_spag == true || SMOOTH == true
    titlestring = ['Epanechnikov bwidth = ' num2str(bandwidth) ' [' num2str(Nsamples) ' resamples]'];
    title(titlestring);
end

axis tight
box off

%OUTPUT
if BOOTSTRAP == true
    Q = [binsX;binsY;CI];
else
    Q = [binsX;binsY];
end
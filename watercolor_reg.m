function [Q, handle] = watercolor_reg(X, Y, bins, bandwidth, varargin)

%----------------------
%SOLOMON HSIANG
%SHSIANG@PRINCETON.EDU
%AUG 2012
%----------------------
%
%[Q, handle] = watercolor_reg(X, Y, BINS, BANDWIDTH, options)
%
%version 1.0
%
%WATERCOLOR_REG estimates a non-parametric regression (Nadaraya-Watson) and
%plots it "visually weighted" based on the observational density of the
%underlying data.  Specifically, the darkness of the distribution is the
%estimated probability that the conditional mean is at a given value.  The
%estimated conditional mean is plotted white, so it contrasts most strongly
%with the probability density when the estimate is more certain. Coloration
%in the probability density function reflects probability mass, so the
%quantity of "ink" used along a vertical line integral is always conserved
%(since the vertical integral of the probability density must equal one).
%The probability density at each value of X is estimated by a kernel 
%density using bootstrapped estimates of the conditional mean. 
%
%For complete details on the regression model, type 'help NWbootstrap_epkv'
%
%OPTIONAL ARGUMENTS:
%   RESAMPLES   - integer scaler
%   COLORVECTOR - three element colorvector
%   CLIPCI      - 'CLIPCI' string clips the coloration at the 95% CI
%   NOLABEL     - 'NOLABEL' string prevents labels on axes and title
%   NOMEAN      - 'NOMEAN' string prevents the conditional mean from being
%                 plotted 
%   BLOCKS      - vector equal in size to X and Y, unique identifier for
%                 blocks to be used in a block boostrap (which is only 
%                 implemented if BLOCKS is specified)
%
%WATERCOLOR_REG(X, Y, BINS, BANDWIDTH, RESAMPLES) specifies the number of
%times that the conditional mean is estimated to construct the probability
%density. A larger value for resamples will produce more accurate results,
%however the completion time of the program is roughly BINS * RESAMPLES. If
%RESAMPLES is not specified, 100 resamples is the default.
%
%WATERCOLOR_REG(X, Y, BINS, BANDWIDTH, COLORVECTOR) plots the maximum color
%as the color specified by the three-element vector COLORVECTOR (eg 
%[0 .3 .9]). If COLORVECTOR is not specified, black is used ([0 0 0]).
%
%WATERCOLOR_REG(X, Y, BINS, BANDWIDTH, 'CLIPCI') forces the colorscale to
%zero coloration at the edge of the 95% confidence interval. To change the
%CI from the 95% default, adjust alpha parameter.
%
%WATERCOLOR_REG(X, Y, BINS, BANDWIDTH, 'NOLABEL') prevents labels for the
%axes and the title describing the number of bootstraps from being plotted.
%
%WATERCOLOR_REG(X, Y, BINS, BANDWIDTH, 'NOMEAN') prevents the conditional
%mean from being plotted as a line. To change the look of the conditional,
%do not specify 'NOMEAN' but instead adjust the variables mean_colorvector
%and linewidthscalar in the first few lines of code.
%
%%WATERCOLOR_REG(X, Y, BINS, BANDWIDTH, BLOCKS) uses unique
%block-identifiers in BLOCKS to do a block bootstrap. The block bootstrap
%preserves the number of blocks in each resample, but this may not conserve
%the overall sample size if the blocks are not sized identically.
%
%The output Q is an structure with the values of x for each bin, and the 
%estimated conditional mean y(x) for that bin.
%
%If output HANDLE is specified, it returns the handle to the figure plotted.
%
%Requires functions 
%       DROP_MISSING_Y.m
%       PLOT_COLORED_FILL.m
%
%NOTE: WATERCOLOR_REG is identical to the "SMOOTH" option of VWREGRESS
%
%NOTE ON SPEED: This code runs faster in parallel, but it checks whether
%the parpool is open or not befor calling parallelized code. For large
%samples, its much faster to compute the bootstrap in parallel (completion
%time falls by 1/5 using 8 cores). Smoothing output from the bootstrap is
%not parallelized and its completion time is proportional to the number of
%bins squared.
%
%See also NWbootstrap_epkv, NWbootstrap_epkv_3D, NWbootstrap, vwregress,
%boxplot_regression
%
%--------------------------------------------------------------------------
%
%WHEN USING THIS CODE, PLEASE CITE: 
%
%   Hsiang, S.M. (2012) "Visually-weighted regression", working paper
%
%THE DEVELOPMENT OF THIS PROCEDURE IS DISCUSSED IN THESE POSTS:
%
%   http://www.fight-entropy.com/2012/08/visually-weighted-confidence-intervals.html
%   http://www.fight-entropy.com/2012/07/visually-weighted-regression.html
%   http://www.fight-entropy.com/2012/08/watercolor-regression.html
%
%THIS FUNCTION AND RELATED FUNCTIONS ARE AVAILABLE FOR DOWNLOAD AT
%   
%   http://www.solomonhsiang.com/computing/data-visualization
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
%     figure
%     watercolor_reg(x, y, 30, 1);
%     figure
%     watercolor_reg(x, y, 100, 1, 150);
%     figure
%     watercolor_reg(x, y, 100, 1, 150, [.5 0 0]);
%
%EXAMPLE FOR BLOCK BOOTSTRAP:
%
%     e = randn(1000,1);
%     block = repmat([1:10]',100,1);
%     x = 2*randn(1000,1);
%     y = x+10*block+e;
%
%     figure
%     plot(x,y,'.')
% 
%     figure
%     watercolor_reg(x,y,50,1,block)
% 
%     figure
%     watercolor_reg(x,y,50,1)
%
%----------------------


%---------------------------------------------------------- parsing options

%set defaults

alpha = 0.05;           %"conserve ink" based on the 95% CI interval

mean_colorvector = [1 1 1]; %set conditional mean is white
linewidthscalar = .5; %conditional mean line width = .5 is default

colorvector = [0 0 0];  %black is default for probability mass color
Nsamples = 100;         %100 resamples is default
CLIPCI = false;         %do not clip coloration at CI is default
NOLABEL = false;        %default to to label plot
BLOCK_BOOTSTRAP = false;%do not use the block bootstrap
blocks = 0;             %not right size, but must have something to pass in parfor loop
Nblocks = 0;            %not right size, but must have something to pass in parfor loop
block_list = [];        %not right size, but must have something to pass in parfor loop
NOMEAN = false;         %plot the conditional mean

%if options are specified
S = size(varargin);


if S(2) > 0
    for s = 1:S(2)
        if isnumeric(varargin{s})
            if length(varargin{s}) == 1
                Nsamples = varargin{s};
            elseif length(varargin{s}) == 3
                colorvector = varargin{s};
            elseif size(varargin{s}) == size(X)
                BLOCK_BOOTSTRAP = true;
                blocks = varargin{s};
                Nblocks = length(unique(blocks));
                block_list = sort(unique(blocks));
                disp(['IMPLEMENTING A BLOCK BOOTSTRAP USING ' num2str(Nblocks) ' BLOCKS'])
            end
        elseif ischar(varargin{s})
            if strcmp(varargin{s}, 'CLIPCI')
                CLIPCI = true;
            elseif strcmp(varargin{s}, 'NOLABEL')
                NOLABEL = true;
            elseif strcmp(varargin{s}, 'NOMEAN')
                NOMEAN = true;
            end
        end
    end
end

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

if BLOCK_BOOTSTRAP == true
    A = [X,blocks];
    
    [Y, A] = drop_missing_Y(Y, A);
    
    X = A(:,1);
    blocks = A(:,2);
    
else
    [Y, X] = drop_missing_Y(Y, X);
end

%---------------------------checking that bandwidth selection is reasonable

if bandwidth*2<(max(X)-min(X))/bins
    disp('WARNING (SOL): BANDWIDTH IS TOO SMALL FOR THE NUMBER OF BINS CHOSEN')
    disp('(INFORMATION MAY BE LOST DUE TO SPARSE SAMPLING)')
end

if bandwidth*2>(max(X)-min(X))
    disp('WARNING (SOL): BANDWIDTH IS SO LARGE THAT INFORMATION IS CARRIED TOO FAR')
    disp('(INFORMATION IS CARRIED ACROSS THE ENTIRE DOMAIN FOR EACH OBSERVATION)')
end

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



%------------------------------ bootstraping estimates for spaghetti and CI

waitmessage = ['BOOTSTRAPPING ' num2str(Nsamples) ' TIMES'];
disp('--------------------------------------------------')
disp(waitmessage)
disp('--------------------------------------------------')

resamples = nan(Nsamples, Nbins);
tic

%check if parpool is open
if ~license('test', 'distrib_computing_toolbox')
    
    disp('--------------------------------------------------')
    disp('FOR GREATER SPEED, CONSIDER OPENING THE MATLABPOOL')
    disp('(RUNS 5X FASTER WITH 8 CORES FOR LARGE SAMPLES)')
    disp('RUNNING BOOTSTRAP IN SERIAL...')
    disp('--------------------------------------------------')
    H = waitbar(0,waitmessage);
    
    %----------BOOTSTRAP IN SERIAL
    for j = 1:Nsamples
        
        if BLOCK_BOOTSTRAP == true
            
            %the random sample of blocks to use
            %this preserves Nblocks, but not N if the blocks are not identically
            %sized
            rs_block_index = ceil(rand(Nblocks,1)*Nblocks); %index of which block to pull [1:Nblocks]
            
            rs_block_values = block_list(rs_block_index); %value of block associated with each index (values same as BLOCKS)
            
            X_rs = [];
            Y_rs = [];
            
            %build each resample by concatinating Nblocks one at a time
            for b = 1:Nblocks
                X_rs = [X_rs; X(blocks==rs_block_values(b))]; %pull all Y vals in block with designated value
                Y_rs = [Y_rs; Y(blocks==rs_block_values(b))]; %pull all Y vals in block with designated value
            end
            
        else %BLOCK_BOOSTRAP == FALSE
            
            rs = ceil(rand(length(X),1)*length(X));
            X_rs = X(rs);
            Y_rs = Y(rs);
        end
        
        waitbar(j/Nsamples,H);
        
        for i = 1:Nbins
            dists_h = (X_rs-binsX(i)*ones(size(X_rs)))/h;
            weights = 3/4*(1-dists_h.^2).*(abs(dists_h)<=1);
            resamples(j,i) = (weights'*Y_rs)/sum(weights);
        end
        
    end
    close(H)
    
else %isOpen == TRUE
    disp('--------------------------------------------------')
    disp('RUNNING BOOTSTRAP IN PARALLEL... NO WAITBAR, SORRY')
    disp('--------------------------------------------------')
    %----------BOOTSTRAP IN PARALLEL (SAME, BUT PARFOR AND NO WAITBAR)
    
    parfor j = 1:Nsamples
        
        if BLOCK_BOOTSTRAP == true
            
            %the random sample of blocks to use
            %this preserves Nblocks, but not N if the blocks are not identically
            %sized
            rs_block_index = ceil(rand(Nblocks,1)*Nblocks); %index of which block to pull [1:Nblocks]
            
            rs_block_values = block_list(rs_block_index); %value of block associated with each index (values same as BLOCKS)
            
            X_rs = [];
            Y_rs = [];
            
            %build each resample by concatinating Nblocks one at a time
            for b = 1:Nblocks
                X_rs = [X_rs; X(blocks==rs_block_values(b))]; %pull all Y vals in block with designated value
                Y_rs = [Y_rs; Y(blocks==rs_block_values(b))]; %pull all Y vals in block with designated value
            end
            
        else %BLOCK_BOOSTRAP == FALSE
            
            rs = ceil(rand(length(X),1)*length(X));
            X_rs = X(rs);
            Y_rs = Y(rs);
        end
        
        %waitbar(j/Nsamples,H);
        for i = 1:Nbins
            dists_h = (X_rs-binsX(i)*ones(size(X_rs)))/h;
            weights = 3/4*(1-dists_h.^2).*(abs(dists_h)<=1);
            resamples(j,i) = (weights'*Y_rs)/sum(weights);
        end
        
        disp(j)
        
    end
    
end
disp('--------------------------------------------------')
disp('BOOTSTRAP COMPLETE')
toc
disp('NOW SMOOTHING MASS FROM RESAMPLES')
disp(['time required proportial to ' num2str(bins) ' squared'])
disp('--------------------------------------------------')



%compute CI to quickly approximate the relative weights needed to conserve
%ink

sorted_samples = sort(resamples);
CI = [sorted_samples(round((1-alpha/2)*Nsamples),:);sorted_samples(round(alpha/2*Nsamples),:)];

binsW = 1./abs(diff(CI,1));
for i=1:length(binsW)
    if isnan(binsW(i))
        binsW(i) = min(binsW);
    end
end

%---------------- computing smoothed distribution of conditional mean prob.

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
Vranges = nan(1,Nbins); %store the grid scale size for each vertical grid

for j = 1:Nbins
    
    %vertical range for each bin
    ylow = min(sorted_samples(:,j));
    yhigh = max(sorted_samples(:,j));
    range_absolute = yhigh-ylow; % the absolute range used for BW selection
    
    if CLIPCI == true; %set to white at the 95%CI if option CLIPCI specified
       ylow = CI(2,j);
       yhigh = CI(1,j);        
    end
    
    range = yhigh-ylow; %differs from absolute range if CLIPCI specified
    
    V_h = range_absolute/10; %set bandwidth to be 1/10 of range
    
    Vgrid_range = range/Vbins;
    
    %bin specific vertical grid
    grid = ylow+Vgrid_range/2:Vgrid_range:yhigh-Vgrid_range/2';
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
    Vranges(j) = Vgrid_range;
    
end

%scale mass by 1/Vgrid_range since narrower grid means more mass in
%each grid cell
if size(Vmasses,1) ~= size(Vmasses,2)
    Vmasses = Vmasses(1:Vbins, 1:Nbins);
end
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

for i = 1:Vbins-1
    %scale the color of each grid row relative to the max in that row
    Vgrid_row_colorvector = [1 1 1]-([1 1 1]-colorvector)*max_Vmass(i);
    
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

%----------------------------------------------------------Plotting results

%plot conditional mean if NOMEAN is not specified as an option
if NOMEAN == false
    handle = plot(binsX,binsY,'Color', mean_colorvector, 'LineWidth', linewidthscalar);
end

%label the plot
if NOLABEL == false
    xlabel('X')
    ylabel('Y')
    box off
    hold on

    titlestring = ['Epanechnikov bwidth = ' num2str(bandwidth) ' [' num2str(Nsamples) ' resamples]'];
    title(titlestring);
end

axis tight
box off
set(gcf,'Color','w')

%OUTPUT

Q = struct('X',binsX,'Y', binsY);

disp('--------------------------------------------------')
disp('           WATERCOLOR REGRESSION DONE')
disp('--------------------------------------------------')


    
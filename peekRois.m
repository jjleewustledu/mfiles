% PEEKROIS
%
%  USAGE:  [grey, basal, white, rois] = peekRois(pid, roiKind, imgFormat, showall)
%
%          pid is a string of form 'vc4354' or 
%              an int index of all the vc-PIDs
%          (optional) roiKind is 'grey', 'basal', 'white' or 'allrois' 
%          (optional) imgFormat is 'double' or 'dip'
%          (optional) showall display all raw ROIs on screen
%
%

function [grey1, basal, white, allrois] = peekRois(pid, varargin)

VERBOSE    = 0;

lenx       = 256;
leny       = 256;
lenz       = 8;
roiKind    = 'allrois';
imgFormat  = 'double';
showall    = 0;
excludeCsf = 1;

switch (nargin)
    case 0
        disp('peekRois(...) requires at least a PID');
        error(help('peekRois'));
    case 1
    case 2
        roiKind   = varargin(1);
    case 3
        roiKind   = varargin(1);
        imgFormat = varargin(2);
    case 4
        roiKind   = varargin(1);
        imgFormat = varargin(2);
        showall   = varargin{3};
    case 5
        roiKind    = varargin(1);
        imgFormat  = varargin(2);
        showall    = varargin{3};
        excludeCsf = varargin{4};
    otherwise 
        error(help('peekRois'));
end
 
if isnumeric(pid)
    p   = pid;
    pid = pidList(pid); 
else
    p   = pidList(pid);
end
roisPath    = perfusionPath(1, fullfile(pid, 'ROIs', 'ErodedXr3d'));
roiTemplate = newim(lenx,leny,lenz,1);
grey1       = roiTemplate;
basal       = roiTemplate;
white       = roiTemplate;
fg          = roiTemplate;
toexclude   = roiTemplate;



%%% I/O

if VERBOSE, disp(['opening ' roisPath 'fg.4dbool.img']); end
try
    fg = read4d([roisPath 'fg.4dbool.img'],'ieee-be','uint8',lenx,leny,lenz,1,0,0,0);
    if (showall)
        fg
        dipmapping('percentile');
    end
catch
    error(disp(['could not find fg ROI in path ' roisPath]));
end 

if VERBOSE, disp(['opening ' roisPath 'toexclude_Xr3d.4dfp.img']); end
try
    toexclude = read4d([roisPath 'toexclude_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
    if (showall)
        toexclude
        dipmapping('percentile');
    end
catch
    error(disp(['could not find toexclude ROI in path ' roisPath]));
end   
   
if (strcmp('allrois', roiKind) || strcmp('grey', roiKind))
    if VERBOSE, disp(['opening ' roisPath 'grey_Xr3d.4dfp.img']); end
    try
        grey = read4d([roisPath 'grey_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        if (showall)
            grey
            dipmapping('percentile');
        end
    catch
        warning(char(['could not find grey ROI in path ' roisPath]));
        grey = roiTemplate;
    end
    if VERBOSE, disp(['opening ' roisPath 'hippocampus_Xr3d.4dfp.img']); end
    try
        hippocampus = read4d([roisPath 'hippocampus_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        if (showall)
            hippocampus
            dipmapping('percentile');
        end
    catch
        warning(char(['could not find hippocampus ROI in path ' roisPath]));
        hippocampus = roiTemplate;
    end
    if VERBOSE, disp(['opening ' roisPath 'cerebellum_Xr3d.4dfp.img']); end
    try
        cerebellum = read4d([roisPath 'cerebellum_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        if (showall)
            cerebellum
            dipmapping('percentile');
        end
    catch
        warning(char(['could not find cerebellum ROI in path ' roisPath]));
        cerebellum = roiTemplate;
    end
    grey1 = grey | hippocampus | cerebellum;
end

if (strcmp('allrois', roiKind) || strcmp('basal', roiKind))
    if VERBOSE, disp(['opening ' roisPath 'caudate_Xr3d.4dfp.img']); end
    try
        caudate = read4d([roisPath 'caudate_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        if (showall)
            caudate    
            dipmapping('percentile');
        end
    catch
        warning(char(['could not find caudate ROI in path ' roisPath]));
        caudate = roiTemplate;
    end
    if VERBOSE, disp(['opening ' roisPath 'putamen_Xr3d.4dfp.img']); end
    try
        putamen = read4d([roisPath 'putamen_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        if (showall)
            putamen
            dipmapping('percentile');
        end
    catch
        warning(char(['could not find putamen ROI in path ' roisPath]));
        putamen = roiTemplate;
    end
    if VERBOSE, disp(['opening ' roisPath 'thalamus_Xr3d.4dfp.img']); end
    try
        thalamus = read4d([roisPath 'thalamus_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        if (showall)
            thalamus
            dipmapping('percentile');
        end
    catch
        warning(char(['could not find thalamus ROI in path ' roisPath]));
        thalamus = roiTemplate;
    end 
    basal = caudate | putamen | thalamus;
end

if (strcmp('allrois', roiKind) || strcmp('white', roiKind))
    if VERBOSE, disp(['opening ' roisPath 'white_Xr3d.4dfp.img']); end
    try
        white = read4d([roisPath 'white_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        if (showall)
            white
            dipmapping('percentile');
        end
    catch
        warning(char(['could not find white ROI in path ' roisPath]));
        white = roiTemplate;
    end
end

% tmp = peekPerfusion(pid, 'ho1');
% tmp = tmp > -10;
% positive_ho1 = newim(grey1);
% positive_ho1(:,:,:,0) = tmp;



%%% FINALIZE

if (excludeCsf)
    finalMsk = fg & ~toexclude;
else
    finalMsk = fg;
end
    
grey1   = grey1; % & positive_ho1;
basal   = basal; % & positive_ho1;
white   = white; % & positive_ho1;
allrois = grey1 + basal + white;
if (showall)
    allrois
    dipmapping('percentile');
end

if strcmp('dip', imgFormat)
    grey1   = scrubNaNs(grey1);
    basal   = scrubNaNs(basal);
    white   = scrubNaNs(white);
    allrois = scrubNaNs(allrois);
else
    grey1   = double(grey1);
    basal   = double(basal);
    white   = double(white);
    allrois = double(allrois);

    if ~isnumeric(grey1),   error(['grey1{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(basal),   error(['basal{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(white),   error(['white{'   num2str(p) '} was not numeric']); end
    if ~isnumeric(allrois), error(['allRois{' num2str(p) '} was not numeric']); end
end

grey1   = grey1   .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allrois));
basal   = basal   .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allrois));
white   = white   .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allrois));
allrois = allrois .* getSliceMask([slice1(p)+1, slice2(p)+1], size(allrois));



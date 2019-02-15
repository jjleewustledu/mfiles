%PEEKPERFUSION
%
%  USAGE:  theImg = peekPerfusion(pid, kindImg, overlayRois, 
%                                 gaussSigmas, imgFormat)
%
%          pid is a string similar to 'vc4354'
%          kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd' or 'ho1' 
%          overlayRois is 1 or 0
%          gaussSigmas is for PET, entered [5, 1] (optional)
%          imgFormat is 'dip' or 'double' (optional)
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function theImg = peekPerfusion(pid, kindImg, overlayRois, gaussSigmas, imgFormat)

% set p -> index, pid -> string i.d.
[pid, p] = ensurePid(pid);

if nargin < 3, overlayRois  = 0; end
if nargin < 4, gaussSigmas = [0, 0]; end
if nargin < 5, imgFormat   = 'double'; end
	
if overlayRois,
	warning(['peekPerfusion:  overlaying pid ' pid ' ' kindImg ' images with ROIs']); end
if gaussSigmas,
	warning(['peekPerfusion:  filtering pid ' pid ' ' kindImg ' images with 3D-Gaussians ' num2str(gaussSigmas)]); end

datapath    = [peekDrive '/perfusion/vc/' pid '/Data/'];
petpath     = [peekDrive '/perfusion/vc/' pid '/PET/'];
bayespath1  = char([datapath '../Bayes/2005oct27_slice' num2str(slice1(p))]);
bayespath2  = char([datapath '../Bayes/2006aug29_slice' num2str(slice2(p))]);
bayespaths  = { bayespath1, bayespath2 };
pdfMetric   = 'mean';
lens        = [256, 256, 8, 1];
blankImg    = newim(lens(1),lens(2),lens(3),lens(4));
theImg      = blankImg;

switch char(kindImg)
    case {'cbfMlem', 'cbfOsvd', 'cbfSsvd'}
        switch char(kindImg)
            case 'cbfMlem'
                theImg = peekDeconvContext('cbf', 'mlem', datapath, lens, imgFormat, p);
            case 'cbfOsvd'
                theImg = peekDeconvContext('cbf', 'osvd', datapath, lens, imgFormat, p);
            case 'cbfSsvd'
                theImg = peekDeconvContext('cbf', 'ssvd', datapath, lens, imgFormat, p);
        end
    case {'cbvMlem', 'cbvOsvd', 'cbvSsvd'}
        switch char(kindImg)
            case 'cbvMlem'
                theImg = peekDeconvContext('cbv', 'mlem', datapath, lens, imgFormat, p);
            case 'cbvOsvd'
                theImg = peekDeconvContext('cbv', 'osvd', datapath, lens, imgFormat, p);
            case 'cbvSsvd'
                theImg = peekDeconvContext('cbv', 'ssvd', datapath, lens, imgFormat, p);
        end
    case {'mttMlem', 'mttOsvd', 'mttSsvd'}
        switch char(kindImg)
            case 'mttMlem'
                theImg = peekDeconvContext('mtt', 'mlem', datapath, lens, imgFormat, p);
            case 'mttOsvd'
                theImg = peekDeconvContext('mtt', 'osvd', datapath, lens, imgFormat, p);
            case 'mttSsvd'
                theImg = peekDeconvContext('mtt', 'ssvd', datapath, lens, imgFormat, p);
        end
    case 'F'
        theImg = peekBayesianContext(p, 'F', pdfMetric, bayespaths, lens, imgFormat);
    case 'CBV'
        theImg = peekBayesianContext(p, 'CBV', pdfMetric, bayespaths, lens, imgFormat);
    case 'CBV_INT'
        theImg = peekBayesianContext(p, 'CBV_INT', pdfMetric, bayespaths, lens, imgFormat);
    case 'Mtt'
        theImg = peekBayesianContext(p, 'Mtt', pdfMetric, bayespaths, lens, imgFormat);
    case 'Delta'
        theImg = peekBayesianContext(p, 'Delta', pdfMetric, bayespaths, lens, imgFormat);
    case 'FracC'
        theImg = peekBayesianContext(p, 'FracC', pdfMetric, bayespaths, lens, imgFormat);
    case 'FracRec'
        theImg = peekBayesianContext(p, 'FracRec', pdfMetric, bayespaths, lens, imgFormat);
    case 'FractDrop'
        theImg = peekBayesianContext(p, 'FractDrop', pdfMetric, bayespaths, lens, imgFormat);
    case 'S0'
        theImg = peekBayesianContext(p, 'S0', pdfMetric, bayespaths, lens, imgFormat);
    case 'S1'
        theImg = peekBayesianContext(p, 'S1', pdfMetric, bayespaths, lens, imgFormat);
    case 'S2'
        theImg = peekBayesianContext(p, 'S2', pdfMetric, bayespaths, lens, imgFormat);
    case 'T0'
        theImg = peekBayesianContext(p, 'T0', pdfMetric, bayespaths, lens, imgFormat);
    case 'T02'
        theImg = peekBayesianContext(p, 'T02', pdfMetric, bayespaths, lens, imgFormat);
    case 'Alpha'
        theImg = peekBayesianContext(p, 'Alpha', pdfMetric, bayespaths, lens, imgFormat);
    case 'Beta'
        theImg = peekBayesianContext(p, 'Beta', pdfMetric, bayespaths, lens, imgFormat);
    case 'ProbModel'
        theImg = peekBayesianContext(p, 'ProbModel', pdfMetric, bayespaths, lens, imgFormat);
    case 'ProbSignal'
        theImg = peekBayesianContext(p, 'ProbSignal', pdfMetric, bayespaths, lens, imgFormat);
    case 'NoiseSd'
        theImg = peekBayesianContext(p, 'NoiseSd', pdfMetric, bayespaths, lens, imgFormat);
    case 'ho1'
        theImg = peekPetContext(p, 'ho1', petpath, lens, gaussSigmas, imgFormat);
    case 'oc1'
        theImg = peekPetContext(p, 'oc1', petpath, lens, gaussSigmas, imgFormat);
    case 'oo1'
        theImg = peekPetContext(p, 'oo1', petpath, lens, gaussSigmas, imgFormat);
    otherwise
        error(['peekPerfusion could not recognize ' kindImg]);
end

if (overlayRois)
    [grey, basal, white, allrois] = peekRois(p, 'allrois', 'dip', 0, excludeCsfRoi(kindImg));
    theImg = peekOverlayROIs(theImg, allrois, kindImg);
else
    switch (char(imgFormat))
        case 'double'
            theImg = double(theImg);
        case 'dip'
            theImg = dip_image(theImg);
        otherwise
            error(['peekPerfusion:  could not recognize imgFormat ' char(imgFormat)]);
    end
end

disp(['peekPerfusion:  size(theImg) -> ' num2str(size(theImg))]);


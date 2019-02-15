% PEEKREFROIS picks out normal-appearing reference tissue
%
%  USAGE:  refRoi = peekRefRois(pid, roiKind, imgFormat, showall)
%
%          pid is a string of form 'vc4354' or 
%              an int index of all the vc-PIDs
%          (optional) roiKind is 'grey', 'basal', 'white' or 'allrois' 
%          (optional) imgFormat is 'double' or 'dip'
%          (optional) showall display all raw ROIs on screen
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function refRoi = peekRefRois(pid, varargin)

VERBOSE   = 1;

lenx      = 256;
leny      = 256;
lenz      = 8;
roiKind   = 'white';
imgFormat = 'dip';
showall   = 0;

switch (nargin)
    case 0
        disp('peekRefRois(...) requires at least a PID');
        error(help('peekRefRois'));
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
    otherwise 
        error(help('peekRefRois'));
end

if ~strcmp('white', roiKind)
    error(['Sorry:  peekRefRois does not currently support roi -> ' roiKind ', only roi -> white']);
end
 
if isnumeric(pid), pid = pidList(pid); end
roisPath    = [peekDrive '/perfusion/vc/' pid '/ROIs/ErodedXr3d/'];
roiTemplate = newim(lenx,leny,lenz,1);
refRoi  = roiTemplate;


%%% I/O

if strcmp('white', roiKind)
    if VERBOSE, disp(['opening ' roisPath 'rostralWhite.4dfp.img']); end
    try
        refRoi = read4d([roisPath 'rostralWhite.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        if (showall)
            refRoi
            dipmapping('percentile');
        end
    catch
        warning(char(['could not find reference white ROI in path ' roisPath]));
        refRoi = roiTemplate;
    end
end



%%% FINALIZE

switch (char(imgFormat))
    case 'dip'
    otherwise
        refRoi = double(refRoi);
end



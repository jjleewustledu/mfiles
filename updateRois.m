%UPDATEROIS
%
%  USAGE:  rois = updateRois(idx)
%          idx is an int
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function rois = updateRois(idx)

pid = pidList(idx);
datapath = [peekDrive() '\perfusion\vc\' pid '\Data\'];
roispath = [peekDrive() '\perfusion\vc\' pid '\ROIs\ErodedXr3d\'];

lenx = 256;
leny = 256;
lenz = 8;

showall = 1;
% disp(['length(varargin) -> ' num2str(length(varargin))]);
% if (length(varargin) > 0) 
%     disp(['varargin -> ' varargin])
%     showall = varargin{1};
% end
onesTemplate  = newim(ones(lenx,leny,lenz,1));
zerosTemplate = newim(zeros(lenx,leny,lenz,1));

disp(['preparing ' roispath 'noSat_Xr3d.4dfp.img']);
try
    cbfSsvd = read4d([datapath 'OSTERGAARD_CBF_SSVD_LOGFRACTAL_VONKEN_NO_FILTER_time' ssvdTimes(idx,'cbf') '.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
    if (1 == idx)
        nosat = cbfSsvd > 0.1;
    else
        nosat = cbfSsvd > 0.00001*max(cbfSsvd);
    end
    if (showall)
        dipfig nosat; nosat    
        dipmapping('percentile');
    end
    write4d(nosat, 'single','ieee-be',[roispath 'noSat_Xr3d.4dfp.img']);
catch
    disp(['INFO:  could not generate no-saturation mask in path ' roispath]);
    disp(['using ' datapath 'OSTERGAARD_CBF_SSVD_LOGFRACTAL_VONKEN_NO_FILTER_time' ssvdTimes(idx,'cbf') '.4dfp.img']);
    caudate = zerosTemplate;
end

disp(['opening ' roispath 'caudate_Xr3d.4dfp.img']);
try
    caudate = read4d([roispath 'caudate_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
    caudate = theUpdate(caudate, nosat);
    if (showall)
        dipfig caudate; caudate    
        dipmapping('percentile');
    end
    write4d(caudate, 'single','ieee-be',[roispath 'caudage_Xr3d.4dfp.img']);
catch
    disp(['INFO:  could not find caudate ROI in path ' roispath]);
    caudate = zerosTemplate;
end

disp(['opening ' roispath 'cerebellum_Xr3d.4dfp.img']);
try
    cerebellum = read4d([roispath 'cerebellum_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
    cerebellum = theUpdate(cerebellum, nosat);
    if (showall)
        dipfig cerebellum; cerebellum
        dipmapping('percentile');
    end
    write4d(cerebellum, 'single','ieee-be',[roispath 'cerebellum_Xr3d.4dfp.img']);
catch
    disp(['INFO:  could not find cerebellum ROI in path ' roispath]);
    cerebellum = zerosTemplate;
end

disp(['opening ' roispath 'grey_Xr3d.4dfp.img']);
try
    grey = read4d([roispath 'grey_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
    grey = theUpdate(grey, nosat);
    if (showall)
        dipfig grey; grey
        dipmapping('percentile');
    end
    write4d(grey, 'single','ieee-be',[roispath 'grey_Xr3d.4dfp.img']);
catch
    disp(['INFO:  could not find grey ROI in path ' roispath]);
    grey = zerosTemplate;
end

disp(['opening ' roispath 'hippocampus_Xr3d.4dfp.img']);
try
    hippocampus = read4d([roispath 'hippocampus_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
    hippocampus = theUpdate(hippocampus, nosat);
    if (showall)
        dipfig hippocampus; hippocampus
        dipmapping('percentile');
    end
    write4d(hippocampus, 'single','ieee-be',[roispath 'hippocampus_Xr3d.4dfp.img']);
catch
    disp(['INFO:  could not find hippocampus ROI in path ' roispath]);
    hippocampus = zerosTemplate;
end

disp(['opening ' roispath 'putamen_Xr3d.4dfp.img']);
try
    putamen = read4d([roispath 'putamen_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
    putamen = theUpdate(putamen, nosat);
    if (showall)
        dipfig putamen; putamen
        dipmapping('percentile');
    end
    write4d(putamen, 'single','ieee-be',[roispath 'putamen_Xr3d.4dfp.img']);
catch
    disp(['INFO:  could not find putamen ROI in path ' roispath]);
    putamen = zerosTemplate;
end

disp(['opening ' roispath 'thalamus_Xr3d.4dfp.img']);
try
    thalamus = read4d([roispath 'thalamus_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
    thalamus = theUpdate(thalamus, nosat);
    if (showall)
        dipfig thalamus; thalamus
        dipmapping('percentile');
    end
    write4d(thalamus, 'single','ieee-be',[roispath 'thalamus_Xr3d.4dfp.img']);
catch
    disp(['INFO:  could not find thalamus ROI in path ' roispath]);
    thalamus = zerosTemplate;
end

disp(['opening ' roispath 'white_Xr3d.4dfp.img']);
try
    white = read4d([roispath 'white_Xr3d.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0);
    white = theUpdate(white, nosat);
    if (showall)
        dipfig white; white
        dipmapping('percentile');
    end
    write4d(white, 'single','ieee-be',[roispath 'white_Xr3d.4dfp.img']);
catch
    disp(['INFO:  could not find white ROI in path ' roispath]);
    white = zerosTemplate;
end

rois = grey | cerebellum | hippocampus | caudate | thalamus | putamen | white;
if (showall)
    dipfig rois; rois
    dipmapping('percentile');
end

function outim = theUpdate(inim, newRoi)
outim = inim & newRoi;


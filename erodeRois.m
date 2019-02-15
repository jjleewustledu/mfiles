%ERODEROIS
%
% Usage:  [caudate, cerebellum, grey, hippocampus, putamen, thalamus, white, composite] = erodeRois(pid)
%
%         pid -> string for patient-ID, commonly the vc-number
%______________________________________________________________________

function [caudate2, cerebellum2, grey2, hippocampus2, putamen2, thalamus2, white2, toexclude, composite] = erodeRois(pid) 

PERF_ROOT  = ['z:\manual backups\perfusion\' pid '\'];
ROI_ROOT   = [PERF_ROOT 'rois\'];
ERODE_ROOT = [ROI_ROOT 'eroded\'];

caudate     = read4d([ROI_ROOT 'caudate.4dfp.img'],    'ieee-be','single',256,256,32,1,0,0,0);
cerebellum  = read4d([ROI_ROOT 'cerebellum.4dfp.img'], 'ieee-be','single',256,256,32,1,0,0,0);
csf         = read4d([ROI_ROOT 'csf.4dfp.img'],        'ieee-be','single',256,256,32,1,0,0,0);
grey        = read4d([ROI_ROOT 'grey.4dfp.img'],       'ieee-be','single',256,256,32,1,0,0,0);
hippocampus = read4d([ROI_ROOT 'hippocampus.4dfp.img'],'ieee-be','single',256,256,32,1,0,0,0);
putamen     = read4d([ROI_ROOT 'putamen.4dfp.img'],    'ieee-be','single',256,256,32,1,0,0,0);
sinus       = read4d([ROI_ROOT 'sinus.4dfp.img'],      'ieee-be','single',256,256,32,1,0,0,0);
thalamus    = read4d([ROI_ROOT 'thalamus.4dfp.img'],   'ieee-be','single',256,256,32,1,0,0,0);
white       = read4d([ROI_ROOT 'white.4dfp.img'],      'ieee-be','single',256,256,32,1,0,0,0);
interior    = read4d([ROI_ROOT 'interior.4dfp.img'],   'ieee-be','single',256,256,32,1,0,0,0);

caudate1 = immorph(caudate,  'open', 3);
caudate1 = immorph(caudate1, 'erode', 1);
caudate1 = immorph(caudate1, 'erode', 2);
caudate1 = immorph(caudate1, 'erode', 3);
caudate2 = caudate1 > -8.01;

cerebellum1 = immorph(cerebellum,  'open', 3);
cerebellum1 = immorph(cerebellum1, 'erode', 1);
cerebellum1 = immorph(cerebellum1, 'erode', 2);
cerebellum2 = cerebellum1 > -5.01;

grey1 = immorph(grey,  'close', 2);
grey1 = immorph(grey1, 'erode', 1);
grey1 = immorph(grey1, 'erode', 2);
grey2 = grey1 > -5.1;

hippocampus1 = immorph(hippocampus,  'open', 2);
hippocampus1 = immorph(hippocampus1, 'erode', 1);
hippocampus1 = immorph(hippocampus1, 'erode', 2);
hippocampus2 = hippocampus1 > -5.01;

putamen1 = immorph(putamen,  'open', 3);
putamen1 = immorph(putamen1, 'erode', 1);
putamen1 = immorph(putamen1, 'erode', 2);
putamen1 = immorph(putamen1, 'erode', 3);
putamen2 = putamen1 > -8.01;

thalamus1 = immorph(thalamus,  'open', 4);
thalamus1 = immorph(thalamus1, 'erode', 1);
thalamus1 = immorph(thalamus1, 'erode', 2);
thalamus1 = immorph(thalamus1, 'erode', 3);
thalamus2 = thalamus1 > -8.01;

white1 = immorph(white,  'open', 3);
white1 = immorph(white1, 'erode', 1);
white1 = immorph(white1, 'erode', 2);
white1 = immorph(white1, 'erode', 3);
white2 = white1 > -8.1;

white2 = white2 & interior;
grey2  = grey2  & interior;

toexclude = caudate2 | cerebellum2 | csf | hippocampus2 | putamen2 | sinus | thalamus2;
grey2     = grey2  & ~toexclude;
white2    = white2 & ~toexclude;

composite = caudate2 | cerebellum2 | hippocampus2 | putamen2 | thalamus2 | grey2 | white2;

write4d(caudate2,    'single','ieee-be', [ERODE_ROOT 'caudate.4dfp.img']);
write4d(cerebellum2, 'single','ieee-be', [ERODE_ROOT 'cerebellum.4dfp.img']);
write4d(grey2,       'single','ieee-be', [ERODE_ROOT 'grey.4dfp.img']);
write4d(hippocampus2,'single','ieee-be', [ERODE_ROOT 'hippocampus.4dfp.img']);
write4d(putamen2,    'single','ieee-be', [ERODE_ROOT 'putamen.4dfp.img']);
write4d(thalamus2,   'single','ieee-be', [ERODE_ROOT 'thalamus.4dfp.img']);
write4d(white2,      'single','ieee-be', [ERODE_ROOT 'white.4dfp.img']);
write4d(toexclude,   'single','ieee-be', [ERODE_ROOT 'toexclude.4dfp.img']);
write4d(composite,   'single','ieee-be', [ERODE_ROOT 'composite.4dfp.img']);

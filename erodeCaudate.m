%ERODEROIS
%
% Usage:  caudate = erodeRois(pid)
%
%         pid -> string for patient-ID, commonly the vc-number
%______________________________________________________________________

function caudate2 = erodeRois(pid) 

PERF_ROOT  = ['z:\manual backups\perfusion\' pid '\'];
ROI_ROOT   = [PERF_ROOT 'rois\'];
ERODE_ROOT = [ROI_ROOT 'eroded\'];

caudate     = read4d([ROI_ROOT 'caudate.4dfp.img'],    'ieee-be','single',256,256,32,1,0,0,0);

caudate1 = immorph(caudate,  'open', 3);
caudate1 = immorph(caudate1, 'erode', 1);
caudate1 = immorph(caudate1, 'erode', 2);
caudate1 = immorph(caudate1, 'erode', 3);
caudate2 = caudate1 > -8.01;

write4d(caudate2,    'single','ieee-be', [ERODE_ROOT 'caudate.4dfp.img']);

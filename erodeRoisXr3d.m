%ERODEROISXR3D
%
% Usage:  [caudate, cerebellum, grey, hippocampus, putamen, thalamus, white, toexclude, composite] = erodeRoisXr3d(pid)
%
%         pid -> string for patient-ID, commonly the vc-number
%______________________________________________________________________

function [interior, caudate2, cerebellum2, grey2, hippocampus2, putamen2, thalamus2, white2, toexclude, composite] = erodeRoisXr3d(pid) 

[pid, p] = ensurePid(pid); 

DEBUG      = 1;
PERF_ROOT  = [peekDrive() '/perfusion/vc/' pid '/']
XR3D_ROOT  = [PERF_ROOT 'ROIs/Xr3d/']
RAW_ROOT   = [PERF_ROOT 'ROIs/Raw/']
XR3D2_ROOT = [PERF_ROOT 'ROIs/ErodedXr3d/']

caudate     = read4d([XR3D_ROOT 'caudate_Xr3d.4dfp.img'],    'ieee-be','single',256,256,8,1,0,0,0);
cerebellum  = read4d([XR3D_ROOT 'cerebellum_Xr3d.4dfp.img'], 'ieee-be','single',256,256,8,1,0,0,0);
%csf         = read4d([RAW_ROOT  'csf_Xr3d.4dfp.img'],             'ieee-be','single',256,256,8,1,0,0,0);
grey        = read4d([XR3D_ROOT 'grey_Xr3d.4dfp.img'],       'ieee-be','single',256,256,8,1,0,0,0);
hippocampus = read4d([XR3D_ROOT 'hippocampus_Xr3d.4dfp.img'],'ieee-be','single',256,256,8,1,0,0,0);
putamen     = read4d([XR3D_ROOT 'putamen_Xr3d.4dfp.img'],    'ieee-be','single',256,256,8,1,0,0,0);
%sinus       = read4d([RAW_ROOT  'sinus_Xr3d.4dfp.img'],           'ieee-be','single',256,256,8,1,0,0,0);
thalamus    = read4d([XR3D_ROOT 'thalamus_Xr3d.4dfp.img'],   'ieee-be','single',256,256,8,1,0,0,0);
white       = read4d([XR3D_ROOT 'white_Xr3d.4dfp.img'],      'ieee-be','single',256,256,8,1,0,0,0);
interior    = read4d([XR3D_ROOT 'interior_Xr3d.4dfp.img'],   'ieee-be','single',256,256,8,1,0,0,0);

%caudate1 = immorph(caudate,  'erode', 1);
%caudate1 = immorph(caudate1, 'erode', 2);
%caudate1 = immorph(caudate1, 'erode', 3);
tmp      = caudate > 0.5; %caudate1 > -8.5;
caudate2 = newim(caudate);
caudate2(:,:,:,0) = tmp;
caudate2 = caudate2 & interior;

cerebellum1 = immorph(cerebellum,  'erode', 1);
cerebellum1 = immorph(cerebellum1, 'erode', 2);
tmp         = cerebellum1 > -5.5;
cerebellum2 = newim(cerebellum);
cerebellum2(:,:,:,0) = tmp;
cerebellum2 = cerebellum & interior;

grey1 = immorph(grey,  'erode', 1);
grey1 = immorph(grey1, 'erode', 2);
tmp   = grey1 > -5.2;
grey2 = newim(grey);
grey2(:,:,:,0) = tmp;
grey2 = grey2 & interior;

hippocampus1 = immorph(hippocampus,  'erode', 1);
hippocampus1 = immorph(hippocampus1, 'erode', 2);
tmp          = hippocampus1 > -5.5;
hippocampus2 = newim(hippocampus);
hippocampus2(:,:,:,0) = tmp;
hippocampus2 = hippocampus2 & interior;

putamen1 = immorph(putamen,  'erode', 1);
putamen1 = immorph(putamen1, 'erode', 2);
tmp      = putamen1 > -5.5;
putamen2 = newim(putamen);
putamen2(:,:,:,0) = tmp;
putamen2 = putamen2 & interior;

thalamus1 = immorph(thalamus,  'erode', 1);
thalamus1 = immorph(thalamus1, 'erode', 2);
tmp       = thalamus1 > -5.5;
thalamus2 = newim(thalamus);
thalamus2(:,:,:,0) = tmp;
thalamus2 = thalamus2 & interior;

white1 = immorph(white,  'close', 3);
white1 = immorph(white1, 'dilate', 1);
tmp    = white1 > 3.333;
white2 = newim(white);
white2(:,:,:,0) = tmp;
white2 = white2 & interior;

%white2 = white2 & interior;
%grey2  = grey2  & interior;

%toexclude = caudate2 | cerebellum2 | csf | hippocampus2 | putamen2 | sinus | thalamus2;
if DEBUG
    disp(['size(caudate)      ->' num2str(size(caudate))]);
    disp(['size(caudate2)     ->' num2str(size(caudate2))]);
    disp(['size(cerebellum)   ->' num2str(size(cerebellum))]);
    disp(['size(cerebellum2)  ->' num2str(size(cerebellum2))]);
    disp(['size(hippocampus)  ->' num2str(size(hippocampus))]);
    disp(['size(hippocampus2) ->' num2str(size(hippocampus2))]);
    disp(['size(putamen)      ->' num2str(size(putamen))]);
    disp(['size(putamen2)     ->' num2str(size(putamen2))]);
    disp(['size(thalamus)     ->' num2str(size(thalamus))]);
    disp(['size(thalamus2)    ->' num2str(size(thalamus2))]);
    disp(['size(grey2)        ->' num2str(size(grey2))]);
    disp(['size(white2)       ->' num2str(size(white2))]);
end
toexclude = caudate | cerebellum | hippocampus | putamen | thalamus;
grey2     = grey2  & ~toexclude & ~white2;
white2    = white2 & ~toexclude & ~grey2;

composite = caudate2 | cerebellum2 | hippocampus2 | putamen2 | thalamus2 | grey2 | white2;

write4d(caudate2,    'single','ieee-be', [XR3D2_ROOT 'caudate_Xr3d.4dfp.img']);
write4d(cerebellum2, 'single','ieee-be', [XR3D2_ROOT 'cerebellum_Xr3d.4dfp.img']);
write4d(grey2,       'single','ieee-be', [XR3D2_ROOT 'grey_Xr3d.4dfp.img']);
write4d(hippocampus2,'single','ieee-be', [XR3D2_ROOT 'hippocampus_Xr3d.4dfp.img']);
write4d(putamen2,    'single','ieee-be', [XR3D2_ROOT 'putamen_Xr3d.4dfp.img']);
write4d(thalamus2,   'single','ieee-be', [XR3D2_ROOT 'thalamus_Xr3d.4dfp.img']);
write4d(white2,      'single','ieee-be', [XR3D2_ROOT 'white_Xr3d.4dfp.img']);
write4d(toexclude,   'single','ieee-be', [XR3D2_ROOT 'toexclude_Xr3d.4dfp.img']);
write4d(composite,   'single','ieee-be', [XR3D2_ROOT 'composite_Xr3d.4dfp.img']);

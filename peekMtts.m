%PEEKMTTS
%
%  USAGE:  [mttMlem, mttOsvd, mttSsvd, mttBayes, mtt1, mtt1gauss] =
%          peekMtts(pid, slice1, slice2, ocFile, hoFile, mlemTime, osvdTime, ssvdTime, rois)
%
%          pid is a string similar to 'vc4354'
%          slice1 & slice 2 are ints for Bayes data from 2005 & 2006
%          datapath is a string similar to 'P:\vc4354\Data\'
%          rois is typically 'grey | basal | white'
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function [mttMlem, mttOsvd, mttSsvd, mttBayes, mtt1, mtt1gauss] = peekMtts(pid, slice1, slice2, ocFile, hoFile, mlemTime, osvdTime, ssvdTime, rois)

% pid      = 'vc4354';
datapath = ['T:\perfusion\' pid '\Data\'];
petpath  = ['T:\perfusion\' pid '\PET\'];

lenx = 256;
leny = 256;
lenz = 8;
gaussSigma = 5;

% mlemTime = '633114914185312500';
% osvdTime = '93';
% ssvdTime = '633117431317968750';

bayesDir1 = ['2005oct27_slice' num2str(slice1) ];
bayesDir2 = ['2006aug29_slice' num2str(slice2) ];
% ocFile    = 'p5761oc1Xr3d';
% hoFile    = 'p5761ho1_Xr3d';

existsSlice2 = 1;
existsPet    = 1;

% read MR and PET data

filename = [datapath 'OSTERGAARD_MTT_MLEM_LOGFRACTAL_VONKEN_NO_FILTER_time' mlemTime '.4dfp.img'];
try
%     dipfig mttMlem;
    mttMlem = read4d(filename,'ieee-be','single',lenx,leny,lenz,1,0,0,0)
    dipmapping('percentile')
catch
    disp(['peekMtts could not read ' filename]);
end
filename = [datapath 'OSTERGAARD_MTT_OSVD_LOGFRACTAL_VONKEN_NO_FILTER_time' osvdTime '.4dfp.img'];
try
% dipfig mttOsvd;
mttOsvd = read4d(,'ieee-be','single',lenx,leny,lenz,1,0,0,0)
dipmapping('percentile')
catch
end
% dipfig mttSsvd;
mttSsvd = read4d([datapath 'OSTERGAARD_MTT_SSVD_LOGFRACTAL_VONKEN_NO_FILTER_time' ssvdTime '.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0)
dipmapping('percentile')
% dipfig mttBayes_slice0;
mttBayes_slice0 = read4d([datapath '..\Bayes\' bayesDir1 '\Mtt.0001.mean.Ascii'],'ascii','single',lenx,leny,1,1,0,0,0)
dipmapping('percentile')
try
%     dipfig mttBayes_slice1;
    mttBayes_slice1 = read4d([datapath '..\Bayes\' bayesDir2 '\Mtt.0001.mean.4dfp.img'],'ieee-be','single',lenx,leny,1,1,0,0,0);
    if ('vc4354' ~= pid) mttBayes_slice1 = flipx4d(mttBayes_slice1); end
    dipmapping('percentile')
catch
    disp(['peekMtts could not find ' bayesDir2 ' for slice2']);
    existsSlice2 = 0;
end
mttBayes = newim(mttSsvd);
mttBayes(:,:,0,0) = mttBayes_slice0;
if (existsSlice2) mttBayes(:,:,1,0) = mttBayes_slice1; end
% dipfig mttBayes; mttBayes
dipmapping('percentile')
try
%     dipfig oc1;
    oc1 = read4d([petpath ocFile '.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0)
    dipmapping('lin')
%     dipfig ho1;
    ho1 = read4d([petpath hoFile '.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0)
    dipmapping('lin')
%     dipfig mtt1;
    mtt1 = oc1/ho1
    dipmapping('percentile')
catch
    disp(['peekMtts could not find one of ' ocFile ' or ' hoFile]);
    existsPet = 0;
end

% make filtered PET counts

if (existsPet)
    mtt1gauss = newim(mtt1);
    for s = 0:lenz - 1
        mtt1gauss(:,:,s,0) = gaussf(oc1(:,:,s,0),gaussSigma)/gaussf(ho1(:,:,s,0),gaussSigma);
    end
%     dipfig mtt1gauss;
    mtt1gauss
    dipmapping('percentile')
end

% show all data with superimposed ROIs

% dipfig mttMlem_rois;
mttMlem_rois = overlay(mttMlem,rois,[200 0 0])
dipmapping('percentile')
% dipfig mttOsvd_rois;
mttOsvd_rois = overlay(mttOsvd,rois,[200 0 0])
dipmapping('percentile')
% dipfig mttSsvd_rois;
mttSsvd_rois = overlay(mttSsvd,rois,[200 0 0])
dipmapping('percentile')
% dipfig mttBayes_slice0_rois;
mttBayes_slice0_rois = overlay(mttBayes_slice0, rois(:,:,0,0), [200 0 0])
dipmapping('percentile')
if (existsSlice2)
%     dipfig mttBayes_slice1_rois;
    mttBayes_slice1_rois = overlay(mttBayes_slice1, rois(:,:,1,0), [200 0 0])
    dipmapping('percentile')
end

% show raw PET counts & filtered PET counts with superimposed ROIs

if (existsPet)
    tmp = 255*mtt1/max(mtt1);
%     dipfig mtt1_rois;
    mtt1_rois      = overlay(tmp,rois,[200 0 0])
    dipmapping('percentile')
    tmp = 255*mtt1gauss/max(mtt1gauss);
%     dipfig mtt1gauss_rois;
    mtt1gauss_rois = overlay(tmp,rois,[200 0 0])
    dipmapping('percentile')
end


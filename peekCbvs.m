%PEEKCBVS
%
%  USAGE:  [cbvMlem, cbvOsvd, cbvSsvd, cbvBayes, oc1, oc1gauss] =
%          peekCbvs(pid, slice1, slice2, ocFile, mlemTime, osvdTime, ssvdTime, rois)
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
function [cbvMlem, cbvOsvd, cbvSsvd, cbvBayes, oc1, oc1gauss] = ...
         peekCbvs(pid, slice1, slice2, ocFile, mlemTime, osvdTime, ssvdTime, rois)

% pid      = 'vc4354';
datapath = ['T:\perfusion\' pid '\Data\'];
petpath  = ['T:\perfusion\' pid '\PET\'];

lenx = 256;
leny = 256;
lenz = 8;
gaussSigma = 5;

% mlemTime = '633114913780625000';
% osvdTime = '78';
% ssvdTime = '633117430850156250';

bayesDir1 = [ '2005oct27_slice' num2str(slice1)];
bayesDir2 = [ '2006aug29_slice' num2str(slice2)];
% ocFile     = 'p5761oc1Xr3d';

existsSlice2 = 1;
existsPet     = 1;

% read MR and PET data

% dipfig cbvMlem;
cbvMlem = read4d([datapath 'OSTERGAARD_CBV_MLEM_LOGFRACTAL_VONKEN_NO_FILTER_time633114913780625000.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0)
dipmapping('percentile')
% dipfig cbvOsvd;
cbvOsvd = read4d([datapath 'OSTERGAARD_CBV_OSVD_LOGFRACTAL_VONKEN_NO_FILTER_time78.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0)
dipmapping('percentile')
% dipfig cbvSsvd;
cbvSsvd = read4d([datapath 'OSTERGAARD_CBV_SSVD_LOGFRACTAL_VONKEN_NO_FILTER_time633117430850156250.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0)
dipmapping('percentile')
% dipfig cbvMttBayes_slice0;
cbvMttBayes_slice0 = read4d([datapath '..\Bayes\2005oct27_slice0\CBV_Mtt.0001.mean.Ascii'],'ascii','single',lenx,leny,1,1,0,0,0)
dipmapping('percentile')
try
%     dipfig cbvBayes_slice1;
    cbvBayes_slice1    = read4d([datapath '..\Bayes\2006aug29_slice1\CBV.0001.mean.4dfp.img'],'ieee-be','single',lenx,leny,1,1,0,0,0)
    if ('vc4354' ~= pid) cbvBayes_slice1 = flipx4d(cbvBayes_slice1); end
    dipmapping('percentile')
catch
    disp(['peekCbvs could not find ' bayesDir2 ' for slice2']);
    existsSlice2 = 0;
end
cbvBayes = newim(cbvSsvd);
cbvBayes(:,:,0,0) = cbvMttBayes_slice0;
if (existsSlice2) cbvBayes(:,:,1,0) = cbvBayes_slice1; end
try
%     dipfig oc1;
    oc1 = read4d([petpath ocFile '.4dfp.img'],'ieee-be','single',lenx,leny,lenz,1,0,0,0)
    dipmapping('lin')
catch
    disp(['peekCbvs could not find ' petpath ocFile]);
    existsPet = 0;
end

% make filtered PET counts

if (existsPet)
    oc1gauss = newim(oc1);
    for s = 0:lenz - 1
        oc1gauss(:,:,s,0) = gaussf(oc1(:,:,s,0),gaussSigma);
    end
%     dipfig oc1gauss;
    oc1gauss
    dipmapping('lin')
end

% show all data with superimposed ROIs

% dipfig cbvMlem_rois;
cbvMlem_rois = overlay(cbvMlem,rois,[200 0 0])
dipmapping('percentile')
% dipfig cbvOsvd_rois;
cbvOsvd_rois = overlay(cbvOsvd,rois,[200 0 0])
dipmapping('percentile')
% dipfig cbvSsvd_rois;
cbvSsvd_rois = overlay(cbvSsvd,rois,[200 0 0])
dipmapping('percentile')
% dipfig cbvMttBayes_slice0_rois;
cbvMttBayes_slice0_rois = overlay(cbvMttBayes_slice0, rois(:,:,0,0), [200 0 0])
dipmapping('percentile')
if (existsSlice2)
%     dipfig cbvBayes_slice1_rois;
    cbvBayes_slice1_rois    = overlay(cbvBayes_slice1,    rois(:,:,1,0), [200 0 0])
    dipmapping('percentile')
end

% show raw PET counts & filtered PET counts with superimposed ROIs

if (existsPet)
    tmp = 255*oc1/max(oc1);
%     dipfig oc1_rois;
    oc1_rois      = overlay(tmp,rois,[200 0 0])
    dipmapping('lin')
    tmp = 255*oc1gauss/max(oc1gauss);
%     dipfig oc1gauss_rois;
    oc1gauss_rois = overlay(tmp,rois,[200 0 0])
    dipmapping('lin')
end


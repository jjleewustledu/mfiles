%PEEKCBFS
%
%  USAGE:  [cbfMlem, cbfOsvd, cbfSsvd, FBayes, ho1, ho1gauss] = 
%          peekCbfs(pid, slice1, sl2, hoFile, mlemTime, osvdTime, ssvdTime, kindRoi, kindImg)
%
%          pid is a string similar to 'vc4354'
%          slice1 & slice 2 are ints for Bayes data from 2005 & 2006
%          datapath is a string similar to 'P:\vc4354\Data\'
%          rois is typically 'grey | basal | white'
%          kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd' or 'ho1' 
%          overlayRois is 1 or 0
%
%  SYNOPSIS:
%
%  SEE ALSO:  
%
%  $Id$
%________________________________________________________________________
function [cbfMlem, cbfOsvd, cbfSsvd, FBayes, ho1, ho1gauss,...
          cbfMlem_rois, cbfOsvd_rois, cbfSsvd_rois, FBayes_rois, ho1_rois, ho1gauss_rois] = ...
          peekCbfs(pid, sl1, sl2, hoFile, mlemTime, osvdTime, ssvdTime, rois, kindImg, overlayRois)

existsSlice1 = 1;
existsSlice2 = 1;
existsPet    = 1;
if nargin < 10, overlayRois  = 1; end

lenx       = 256;
leny       = 256;
lenz       = 8;
gaussSigma = 5;

if (isnumeric(pid))
    pid = pidList(pid);
end
% don't do this with sl1 or sl2, which map numeric -> numeric...
if (isnumeric(hoFile))
    hoFile = hoFileList(hoFile);
end
% don't do this for the *Time fields either; error-prone
if (overlayRois)
    [grey_,  basal_,  white_,  rois_ ] = peekRois(pid)
    [greyp_, basalp_, whitep_, roisp_] = peekRois(pid, 'allrois', 'dip', 0, 0);
    rois = rois_;
end

datapath = [peekDrive '\perfusion\vc\' pid '\Data\'];
petpath  = [peekDrive '\perfusion\vc\' pid '\PET\'];

bayesDir1 = char(['2005oct27_slice' num2str(sl1)]);
bayesDir2 = char(['2006aug29_slice' num2str(sl2)]);

blankImg = newim(lenx,leny,lenz,1);



% read MR

cbfMlem = blankImg;
if (strcmp('cbfMlem', kindImg))
    try
%%%        if (strcmp(pidList(10), pid) || strcmp(pidList(11), pid) || strcmp(pidList(12), pid))
%%%            name = [datapath 'OSTERGAARD_CBF_MLEM_LOGFRACTAL_VONKEN_NO_FILTER.4dfp.img'];
%%%            cbfMlem = read4d(name,'ieee-be','single',lenx,leny,lenz,1,0,0,0);
%%%        else
%%%        end

        name = [datapath 'OSTERGAARD_CBF_MLEM_LOGFRACTAL_VONKEN_NO_FILTER_LMfit2.4dfp.img'];
        cbfMlem = read4d(name,'ieee-be','single',lenx,leny,lenz,1,0,0,0);            
        disp(['peekCbfs found ' name]);
    catch
        try
            name = [datapath 'OSTERGAARD_CBF_MLEM_LOGFRACTAL_VONKEN_NO_FILTER_time' mlemTime '.4dfp.img'];
            cbfMlem = read4d(name,'ieee-be','single',lenx,leny,lenz,1,0,0,0);
            disp(['peekCbfs found ' name]);
        catch
            error(['cbfMlem was requested but could not be read from ' name]);
        end
    end
end

cbfOsvd = blankImg;
if (strcmp('cbfOsvd', kindImg))
    try
        name = [datapath 'OSTERGAARD_CBF_OSVD_LOGFRACTAL_VONKEN_NO_FILTER_LMfit2.4dfp.img'];
        cbfOsvd = read4d(name,'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        disp(['peekCbfs found ' name]);
    catch
        try
            name = [datapath 'OSTERGAARD_CBF_OSVD_LOGFRACTAL_VONKEN_NO_FILTER_time' mlemTime '.4dfp.img'];
            cbfOsvd = read4d(name,'ieee-be','single',lenx,leny,lenz,1,0,0,0);
            disp(['peekCbfs found ' name]);
        catch
            error(['cbfOsvd was requested but could not be read from ' name]);
        end
    end
end

cbfSsvd = blankImg;
if (strcmp('cbfSsvd', kindImg))
    try
        name = [datapath 'OSTERGAARD_CBF_SSVD_LOGFRACTAL_VONKEN_NO_FILTER_time' ssvdTime '.4dfp.img'];
        cbfSsvd = read4d(name,'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        disp(['peekCbfs found ' name]);
    catch
        try
            name = [datapath 'OSTERGAARD_CBF_SSVD_LOGFRACTAL_VONKEN_NO_FILTER_LMfit2.4dfp.img'];
            cbfSsvd = read4d(name,'ieee-be','single',lenx,leny,lenz,1,0,0,0);
            disp(['peekCbfs found ' name]);
        catch
            error(['cbfSsvd was requested but could not be read from ' name]);
        end
    end
end



% reading Bayesian data

FBayes = blankImg;
if (strcmp('F', kindImg))
    fname1 = [datapath '..\Bayes\' bayesDir1 '\F.0001.mean.Ascii'];
    try    
        FBayes_slice1 = read4d(fname1,'ascii','single',lenx,leny,1,1,0,0,0);
        disp(['peekCbfs found ' fname1 ' for sl1']);
    catch
        warning(char(['peekCbfs could not find ' fname1 ' for sl1']));
        existsSlice1 = 0;
    end

    fname2 = [datapath '..\Bayes\' bayesDir2 '\F.0001.mean.4dfp.img'];
    try
        FBayes_slice2 = read4d(fname2,'ieee-be','single',lenx,leny,1,1,0,0,0);
        FBayes_slice2 = flipx4d(FBayes_slice2); 
        disp(['peekCbfs found ' fname2 ' for sl2, but needed to flip the orientation of x']);
    catch
        disp(['peekCbfs could not find ' fname2 ' for sl2']);
        existsSlice2 = 0;
    end

    if existsSlice1, FBayes(:,:,sl1,0) = squeeze(FBayes_slice1); end
    if existsSlice2, FBayes(:,:,sl2,0) = squeeze(FBayes_slice2); end
end



% read PET counts and make filtered PET counts

ho1      = blankImg;
ho1gauss = blankImg;
if (strcmp('ho1', kindImg))
    hname = [petpath hoFile '.4dfp.img'];
    try
        ho1 = read4d(hname,'ieee-be','single',lenx,leny,lenz,1,0,0,0);
        if strcmp('vc4405', pid), 
            ho1 = flipx4d(ho1); 
            disp(['peekCbfs found ' hname ', but needed to flip the orientation of x']);
        else
            disp(['peekCbfs found ' hname]);
        end
    catch
        disp(['peekCbfs could not find ' hname]);
    end
    ho1gauss = gaussAnisof(ho1, [1 1 gaussSigma]);
end



% overlay all data with superimposed ROIs

cbfMlem_rois  = blankImg;
cbfOsvd_rois  = blankImg;
cbfSsvd_rois  = blankImg;
FBayes_rois   = blankImg;
ho1_rois      = blankImg;
ho1gauss_rois = blankImg;

if (overlayRois)
    cbfMlem_rois = overlay(cbfMlem,rois,[200 0 0]);
    cbfOsvd_rois = overlay(cbfOsvd,rois,[200 0 0]);
    cbfSsvd_rois = overlay(cbfSsvd,rois,[200 0 0]);
    FBayes_rois  = overlay(FBayes, rois,[200 0 0]);

    % show raw PET counts & filtered PET counts with superimposed ROIs
    roisp_ = squeeze(roisp_);
    if (existsPet) 
        if (max(ho1) > 0)
            tmp = squeeze(255*ho1/max(ho1));
        else
            tmp = squeeze(ho1);
        end
        ho1_rois = overlay(tmp,roisp_,[200 0 0]);

        if (max(ho1gauss) > 0)
            tmpgauss = squeeze(255*ho1gauss/max(ho1gauss));
        else
            tmpgauss = squeeze(ho1gauss);
        end
        ho1gauss_rois = overlay(tmpgauss,roisp_,[200 0 0]);
    else
        ho1_rois      = overlay(squeeze(ho1),     roisp_,[200 0 0]);
        ho1gauss_rois = overlay(squeeze(ho1gauss),roisp_,[200 0 0]);
    end
end


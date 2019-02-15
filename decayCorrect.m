function [nii,times,taus] = decayCorrect(nii, isotope, startTime, useBecquerels)
%% DECAYCORRECT ... 
%   
%  Usage:  [nifti,times,durations] = decayCorrect(nifti, isotope, startTime, useBecquerels) 
%                 ^     ^ double
%                                                        ^ char:  "15O", "11C"
%                                                                 ^ float, sec
%                                                                            ^ bool:  divide by sampling durations of each time-frame
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

%%if (~exist('useBecquerels', 'var')); useBecquerels = false; end

sz = nii.size;
NN = 55;
switch (isotope)
    case '15O'        
        halfLife           = 122.1;
        lambda             = log(2) / halfLife; % lambda \equiv 1/tau, tau = 1st-order rate constant 
        times              = zeros(1,NN);
        taus               = zeros(1,NN);
        img                = zeros(sz(1),sz(2),sz(3),NN);
        img(:,:,:,1:sz(4)) = nii.img;
        nii.pixdim(4)      = 2;
        
        times( 1:31) = startTime +      2*([2:32] - 2);
        times(32:NN) = startTime + 60 + 6*([33:NN+1] - 32);

        taus( 1:30) = 2;
        taus(31:NN) = 6;
        
        if (useBecquerels)
            scaling = [2 6]; %#ok<*UNRCH> % duration of sampling
        else
            scaling = [1 1];
        end
        
        for t = 1:30
            img(:,:,:,t) = img(:,:,:,t) * exp(lambda * times(t)) / scaling(1); end
        for t = 31:NN
            img(:,:,:,t) = img(:,:,:,t) * exp(lambda * times(t)) / scaling(2); end
        
    case '11C'
        halfLife           = 20.334*60;
        lambda             = log(2) / halfLife;
        times              = zeros(1,NN);
        taus               = zeros(1,NN);
        img                = zeros(sz(1),sz(2),sz(3),NN);
        img(:,:,:,1:sz(4)) = nii.img;
        nii.pixdim(4)      = 30;
        
        times( 1:17) = startTime +         30*([ 2:18] -  2); %#ok<*NBRAK>
        times(18:25) = startTime + 480  +  60*([19:26] - 18);
        times(26:41) = startTime + 960  + 120*([27:42] - 26);
        times(42:49) = startTime + 2880 + 180*([43:50] - 42);
        times(50:NN) = startTime + 4320 + 240*([51:NN+1] - 50);

        taus( 1:16) = 30;
        taus(17:24) = 60;
        taus(25:40) = 120;
        taus(41:48) = 180;
        taus(49:NN) = 240;        
        
        if (useBecquerels)
            scaling = [30 60 120 180 240]; % duration of sampling
        else
            scaling = [1 1 1 1 1];
        end
        
        for t = 1:16
            img(:,:,:,t) = img(:,:,:,t) * exp(lambda * times(t)) / scaling(1); end
        for t = 17:24
            img(:,:,:,t) = img(:,:,:,t) * exp(lambda * times(t)) / scaling(2); end
        for t = 25:40
            img(:,:,:,t) = img(:,:,:,t) * exp(lambda * times(t)) / scaling(3); end
        for t = 41:48
            img(:,:,:,t) = img(:,:,:,t) * exp(lambda * times(t)) / scaling(4); end
        for t = 49:NN
            img(:,:,:,t) = img(:,:,:,t) * exp(lambda * times(t)) / scaling(5); end
         
    otherwise
        error('mfiles:unsupportedPropertyValue', 'decayCorrect did not recognize %s', isotope);
end

nii.img = img(:,:,:,1:sz(4));
times   = times(1:sz(4));
taus    = taus( 1:sz(4));
nii.fileprefix = [nii.fileprefix '_decayCorrect'];
if (useBecquerels)
    nii.fileprefix = [nii.fileprefix '_Bq']; end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/decayCorrect.m] ======  

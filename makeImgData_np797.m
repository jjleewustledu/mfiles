
%
% Usage:    idat = makeImgData_np797(pid, metric)
%
%           pid:     string or int index
%           metric:  as for idat.images{*}.metric
%
%           idat:    struct containing:
%                    study
%                    pid
%                    basepath
%                    petfolder
%                    mrfolder
%                    abscissaToPlot
%                    ordinateToPlot
%                    sizes
%                    images{i}:  modality, processing, imageName, imageSafeName, metric, units, binimage, ...
%                                fwhh, mmppix, flows, w, integralCa, a
%
%                                metric $\in$ {'cbf', 'cbv', 'mtt', 'ho1', 'oc1', 'oo1', 'oef', 'cmro2', ...
%                                                 'f', 'delta', 'alpha', 'beta', 's0', 's1', 's2', 't0', 't1', 't2'}
%                                modality $\in$ {'pet', 'mr'}
%
%___________________________________________________________________________________________________________________

function idat = makeImgData_np797(pid, metric)
	
    pid = ensurePid(pid);
	
    idat                         = mlfsl.ImagingComponent;
    idat.study                   = pid2np(pid);
    idat.pid                     = pid;
    idat.pnum                    = pnum;
    idat.basepath                = ['/mnt/hgfs/' idat.study '/'];
    idat.petfolder               = petFolderName(idat.study);
    idat.mrfolder                = mrFolderName( idat.study);
    idat.sizes                   = db('sizes3d', idat.study);
    idat.sizes3d                 = db('sizes3d', idat.study);

	idat.masks                   = false;
    
    idat.images{1}.modality      = 'pet';
    idat.images{1}.binimage      = newim(db('sizes3d', idat.study));
    idat.images{1}.scaleFactor   = 1;
    [flowA flowB]                = petFlows(pid);
    idat.images{1}.flows         = [flowA flowB];
    idat.images{1}.w             = modelW(pid);
    idat.images{1}.integralCa    = modelIntegralCa(pid);
    idat.images{1}.fwhh          = db('petblur', idat.study);
    idat.images{1}.mmppix        = db('mmppix',  idat.study);
	idat.images{1}.range		 = [];

    idat.images{2}.modality      = 'mr';
    idat.images{2}.processing    = 'shin-carroll';
    idat.images{2}.binimage      = newim(db('sizes3d', idat.study));
    idat.images{2}.scaleFactor   = 1;
    idat.images{2}.fwhh          = db('mrblur', idat.study);
    idat.images{2}.mmppix        = db('mmppix', idat.study);
	idat.images{2}.range		 = [];
	
    idat.images{3}.modality      = 'mr';
    idat.images{3}.processing    = 'ssvd';
    idat.images{3}.binimage      = newim(db('sizes3d', idat.study));
    idat.images{3}.scaleFactor   = 1;
    idat.images{3}.fwhh          = db('mrblur', idat.study);
    idat.images{3}.mmppix        = db('mmppix', idat.study);
	idat.images{3}.range		 = [];

    switch (lower(metric))
        case {'cbf','f'}
            idat.images{1}.metric        = 'cbf';
            idat.images{1}.imageName     = 'PET H_2[^{15}O] CBF'; % 'PET C[^{15}O]-H_2[^{15}O] MTT' % 'PET C[^{15}O] CBV';
            idat.images{1}.imageSafeName = 'PET H2O CBF';
            idat.images{1}.units         = 'mL/min/100 g';
            idat.images{1}.supValue      = 110;
            
            idat.images{2}.metric        = 'CBF';
            idat.images{2}.imageName     = 'MR qCBF';  
            idat.images{2}.imageSafeName = 'MR qCBF';
            idat.images{2}.units         = 'mL/min/100 g';
            idat.images{2}.supValue      = idat.images{1}.supValue;
            
            idat.images{3}.metric        = 'CBF';
            idat.images{3}.imageName     = 'MR sSVD CBF';   
            idat.images{3}.imageSafeName = 'MR sSVD CBF';
            idat.images{3}.units         = 'Arbitrary';
            idat.images{3}.supValue      = idat.images{1}.supValue;
            
        case {'cbv'}
            idat.images{1}.metric        = 'cbv';            
            idat.images{1}.imageName     = 'PET H_2[^{15}O] CBV'; % 'PET C[^{15}O]-H_2[^{15}O] MTT' % 'PET C[^{15}O] CBV';
            idat.images{1}.imageSafeName = 'PET H2O CBV';
            idat.images{1}.units         = 'mL/100 g';
            idat.images{1}.supValue      = 100;
            
            idat.images{2}.metric        = 'CBV';
            idat.images{2}.imageName     = 'MR qCBV';  
            idat.images{2}.imageSafeName = 'MR qCBV';
            idat.images{2}.units         = 'mL/100 g';
            idat.images{2}.supValue      = idat.images{1}.supValue;
            
            idat.images{3}.metric        = 'CBV';
            idat.images{3}.imageName     = 'MR sSVD CBV';   
            idat.images{3}.imageSafeName = 'MR sSVD CBV';
            idat.images{3}.units         = 'mL/100 g';
            idat.images{3}.supValue      = idat.images{1}.supValue;
            
        case {'mtt'}
            idat.images{1}.metric        = 'mtt';
            idat.images{1}.imageName     = 'PET MTT'; % 'PET C[^{15}O]-H_2[^{15}O] MTT' % 'PET C[^{15}O] CBV';
            idat.images{1}.imageSafeName = 'PET MTT';
            idat.images{1}.units         = 'sec'; 
            idat.images{1}.supValue      = 10;
            
            idat.images{2}.metric        = 'MTT';
            idat.images{2}.imageName     = 'MR qMTT';  
            idat.images{2}.imageSafeName = 'MR qMTT';
            idat.images{2}.units         = 'sec';
            idat.images{2}.supValue      = idat.images{1}.supValue;
            
            idat.images{3}.metric        = 'MTT';
            idat.images{3}.imageName     = 'MR sSVD MTT';   
            idat.images{3}.imageSafeName = 'MR sSVD MTT';
            idat.images{3}.units         = 'sec';
            idat.images{3}.supValue      = idat.images{1}.supValue;
            
        otherwise
            error(['makeImgData_np797:  could not recognize metric ' metric]);
    end
    
    for i = 1:3
        idat = readImage(idat, i);
        idat.images{i}.binimage = ...
            idat.images{i}.scaleFactor * idat.images{i}.binimage .* ...
            (idat.images{i}.binimage < idat.images{i}.supValue);
    end
    
    for i = 1:3
         idat.images{i}.study = 'np797';
         idat.images{i}.pid   = pid;
         idat.images{i}.pnum  = pid;
         idat.images{i}.ifh   = [];
         idat.images{i}.rec   = [];
    end
    
end

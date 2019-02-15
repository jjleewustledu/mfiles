
%
% Usage:    imgData = makeImgData(pid)
%
%           pid:        string or int index
%
%           imgData:    struct containing:
%                       study
%                       pid, pnum
%                       basepath
%                       petfolder
%                       mrfolder
%                       abscissaToPlot
%                       ordinateToPlot
%                       sizes
%                       images{i}:  modality, processing, imageName, imageSafeName, metric, units, dipImage, ...
%                                   fwhh, mmppix, flows, w, integralCa, a 
%
%                                   metric $\in$ {'cbf', 'cbv', 'mtt', 'ho1', 'oc1', 'oo1', 'oef', 'cmro2', ...
%                                                 'f', 'delta', 'alpha', 'beta', 's0', 's1', 's2', 't0', 't1', 't2'}
%                                   modality $\in$ {'pet', 'mr'}
%
% Note:     dipImage data are not assigned
%
%___________________________________________________________________________________________________________________

function imgData = makeImgData(pid, metric)
	
	pb                   = db('petblur');
	mb                   = db('mrblur');
    BLUR_LBL_1           = ['_' num2str(pb(1)) 'mm'];    
    BLUR_LBL_2           = ['_' num2str(mb(1)) 'mm'];

    switch (nargin)
        case 1
            metric = 'cbf';
        case 2
        otherwise
            error(help('makeImgData'));
    end
	
	[pid p] = ensurePid(pid);
    
    switch (pid2np(pid))
        case 'np287'
            imgData = makeImgData_np287(pid, metric);
        case 'np797'
            imgData = makeImgData_np797(pid, metric);
        otherwise
            error(['makeImgData:  could not recognize pid2np' pid2np(pid)]);
    end
    
    for i = 2:3
        imgData.images{i}.printProps = mlpublish.ScatterPublisher.makePrintProps(...
            [imgData.images{1}.imageSafeName ' vs ' imgData.images{i}.imageSafeName ' 4-scatter ' BLUR_LBL_2], ...
            'Title', ...
            [imgData.images{1}.imageName     ' / '  imgData.images{1}.units ''], ...
            [imgData.images{i}.imageName     ' / '  imgData.images{i}.units ''], ...
            'Legend Label');
    end
    
    imgData.pnum = imgData.pid;
	
    
%
% Usage:  function [img theIfh] = fdf_to_4dfp(...
%         study, pathname, metric, fqfn_lastrec, pid, ...
%         scals, lens, paramFil, seqFil, seqDesc, comm)
%
%         study    <- 'np287', 'np797'
%         pathname <- 
%         metric   <- 'CBV', 'F', 'MTT', etc.
%         fqfn_lastrec 
%         pid
%         scals    <- [scalx scaly scalz]
%         lens     <- [lenx  leny  lenz  lent]
%         paramFil <- name of MR parameter file
%         seqFil   <- name of MR sequence file
%         seqDesc
%         comm     <- comments
%

function [img theIfh] = fdf_to_4dfp(...
    study, pid, pathname, metric, fqfn_lastrec, ...
    scals, lens, paramFil, seqFil, seqDesc, comm)

    CENTRAL = 'mean';
    
    switch (nargin)
        case 5
            scals = [1.73 1.73 6.50 1];
            scals(4) = 1;
            lens = [128 128 13 1];
            lens(4) = 1;
            paramFil = '';
            seqFil = '';
            seqDesc = 'ep2d_perf';
            comm = '';
        case 7
            paramFil = '';
            seqFill = '';
            seqDesc = 'ep2d_perf';
        case 10
            comm = '';
        case 11
        otherwise
            error(help(['fdf_to_4dfp']));
    end
    
    img = newim(lens(1),lens(2),lens(3));
    hdr = 0;
    for s = 0:lens(3)-1
        t = s+1;
        if (t < 10)
            filename = [metric '.000' num2str(t) '.' CENTRAL '.fdf'];
        elseif (t < 100)
            filename = [metric '.00' num2str(t)  '.' CENTRAL '.fdf'];
        else
            error(['fdf_to_4df:  could not manage slice ' num2str(t)]);
        end
        try
            disp(filename)
          [img(:,:,s) hdr] = nilio_fdf([pathname filename], study);
        catch ME
          disp(getReport(ME));
          error(['fdf_to_4dfp.nilio_fdf(...) failed for ' strcat([pathname filename '.4dfp'])]);  
        end
    end
    filestem_4dfp = [metric '_' CENTRAL '.4dfp'];
    fqfn_4dfp  = [pathname metric '.4dfp'];  



    % write .4dfp.img ____________________________________

    write4d(img, 'single', 'ieee-be', [fqfn_4dfp '.img']);

    
    
    % write .4dfp.ifh ________________________________________

    theIfh.imageModality = 'mri';
    theIfh.originatingSystem = 'Siemens Trio 3T TIM';
    theIfh.conversionProgram = 'fdf_to_4dfp.m';
    theIfh.programVersion = '2008apr17';
    theIfh.nameOfDataFile = [filestem_4dfp '.img'];
    theIfh.patientID = pid;
    theIfh.numberFormat = 'float';
    theIfh.bytesPerPixel = 4;
    theIfh.orientation = 2; % axial
    theIfh.numberOfDimensions = 4;
    theIfh.scalingFactorX = scals(1);
    theIfh.scalingFactorY = scals(2);
    theIfh.scalingFactorZ = scals(3);
    theIfh.scalingFactors = scals;
    theIfh.sliceThickness = db('slice thickness');
    theIfh.lengthX = lens(1);
    theIfh.lengthY = lens(2);
    theIfh.lengthZ = lens(3);
    theIfh.lengthT = lens(4);
    theIfh.lengths = lens;
    theIfh.parameterFilename = paramFil;
    theIfh.sequenceFilename = seqFil;
    theIfh.sequenceDescription = seqDesc;
    theIfh.comment = ['from study ' study];
    theIfh.blank = '';
    theIfh
    nilio_writeIfh2(theIfh, strcat([fqfn_4dfp '.ifh']));
    
    

    % write 4dfp.img.rec ________________________________________________

    lastRecord = '';
    disp(['fqfn_lastrec -> ' fqfn_lastrec]);
    fid        = fopen(fqfn_lastrec, 'rt');
    line       = fgetl(fid);
    disp(line)
    while (-1 ~= line)
        % if (findstr('rec', line) ~= 1 & findstr('endrec', line) ~= 1)
            lastRecord = strcat([lastRecord line '\n']);
        % end
        line = fgetl(fid);
        disp(line)
    end
    fclose(fid);
    thisRecord = strcat(['rec ' theIfh.nameOfDataFile ' ' datestr(now) ' jjlee\n' ...
                         'fdf_to_4dfp(\''' pathname '\'', \''' filename '\'', \''' pid ... 
                         '\'', [' num2str(scals) '], [' num2str(lens) '], \''' paramFil...
                         '\'' , \''' seqFil '\'', \''' seqDesc '\'')\n' ...
                         'version of ' datestr(now) ' jjlee\n\n' lastRecord '\n' ...
                         'end rec ' datestr(now) ' jjlee\n']);
    nilio_writeRec(thisRecord, strcat([fqfn_4dfp '.img.rec']));

    
    

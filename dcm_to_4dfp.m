
% 
% USAGE:    dcm_to_4dfp(pth)
%
%           pth:   fully qualified path to folder of sorted dicom files
%
% SEE ALSO: dcm_sort
%

function [newimg newmd] = dcm_to_4dfp(basename, pth)

    workpath = pwd
    cd(pth); disp('path to data ='); disp(pth);

    dcmdir = dir(pth); 
    len    = length(dcmdir) - 2;
    extras = 0;
    newuid = dicomuid;
    newmd  = 0;
    newimg = cell(1,len);
    for i = 1:len
        try
            metadata  = dicominfo(dcmdir(i+2).name);
            newimg{i} = dicomread(metadata);
            
            % process only the first series found in the folder
            if (1 == i)
                newmd                   = metadata;
                newmd.SeriesInstanceUID = newuid;
                disp(['dcm_to_4dfp:  processing series '...
                      newmd.SeriesDescription]);
            end
            
            % check that there are no other series in the folder
            if (~strcmp(newmd.SeriesDescription, metadata.SeriesDescription))
                extras = extras + 1;
                disp(['dcm_to_4dfp:  found unexpected image with SeriesDescription '...
                      metadata.SeriesDescription]);                
            end            
        catch ME
            disp(ME.message);
        end
    end
    
    cd(workpath);
    
    % write .4dfp.img
    
    dipimg = newim(size(newimg{1}), len-extras, 1); 
    nameofdatafile = [basename '.4dfp.img'];
    write4d(dipimg, 'float', 'ieee-be', nameofdatafile);
    
    % write .4dfp.ifh
    
    ifh.nameOfDataFile = nameofdatafile;
    ifh.patientID      = newmd.;
    ifh.numberFormat   = 'float';
    ifh.orientation    = newmd.;
    ifh.scalingFactors = [newmd.PixelSpacing(1) ...
                          newmd.PixelSpacing(2) ...];
    ifh.sliceThickness = newmd.SliceThickness;
    ifh.lengths        = ;
    
    ifh.conversionProgram   = 'dcm_to_4dfp.m';
    ifh.originatingSystem   = newmd.;
    ifh.imageModality       = newmd.;
    ifh.model               = newmd.;
    ifh.studyDate           = newmd.StudyDate;
    ifh.bytesPerPixel       = ;
    ifh.numberOfDimensions  = 4;
    ifh.parameterFilename   = newmd.;
    ifh.sequenceFilename    = newmd.;
    ifh.sequenceDescription = newmd.;
    
    % write .4dfp.img.rec
    
    
    
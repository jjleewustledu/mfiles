
% 
% USAGE:    dcm_sort(basename, pth)
%
%           pth:   fully qualified path to folder of dicom files
%

function dcm_sort(pth)

    workpath = pwd;
    cd(pth); disp('path to data ='); disp(pth);

    dcmdir    = dir(pth);
    seriestag = '';
    iseries   = 0;
    for i = 3:length(dcmdir) %#ok<*FORFLG,*PFUNK>
        try
            dcmmetadata = dicominfo(dcmdir(i).name);
            dcmimage    = dicomread(dcmmetadata{i});
            if (~strcmp(seriestag, dcmmetadata{i}.SeriesDescription)) % start of new series
                seriestag = dcmmetadata.SeriesDescription;
                iseries = iseries + 1;
                slcount = 0;
                mkdir([workpath '/series' num2str(iseries)]);
                cd(   [workpath '/series' num2str(iseries)])
                newuid = dicomuid;
            end
            dcmmetadata.SeriesInstanceUID = newuid;
            slcount = slcount + 1;
            dicomwrite(dcmimage, dcmdir(i).name, dcmmetadata);
            catalog{iseries}.SequenceName      = dcmmetadata.SequenceName; %#ok<*AGROW>
            catalog{iseries}.SeriesDescription = dcmmetadata.SeriesDescription;
            catalog{iseries}.ProtocolName      = dcmmetadata.ProtocolName;
            catalog{iseries}.SeriesInstanceUID = newuid;
            catalog{iseries}.NumberOfImages    = slcount;
        catch ME
            disp(ME.message);
        end
    end

    cd(workpath);
    diary([mlfourd.AbstractDicomConverter.dicomFolders{1} '.series.txt']);
    spaces = '          ';
    for j = 1:length(catalog)
        try
           disp([num2str(i) spaces catalog{i}.ProtocolName spaces catalog{i}.SequenceName spaces num2str(catalog{i}.NumberOfImages)]);
        catch ME
            disp(ME.message);
        end
    end
    diary off;
    
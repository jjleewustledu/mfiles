
% Usage:  [dsa, dsametadata] = dsa_moving_average(pth, tau, msk)
%
%         dsa:  double image
%         dsametadata:  dicom meta-data
%         pth:  path to DICOMs to read; output written to current directory
%         tau:  duration of moving average
%         msk:  logical mask
%

function [dsa dsametadata] = dsa_moving_average(pth, tau, msk)

     switch (nargin)
          case 2
               assert(ischar(pth),    ['class(pth) was unexpectedly ' class(pth)]);
               assert(isnumeric(tau), ['class(tau) was unexpectedly ' class(tau)]);
               usemsk = 0;
          case 3
               usemsk = 1;
          otherwise
               error(help('dsa_moving_average'));
     end

     IOD = 'Secondary Capture Image Storage';
     
     workpath    = pwd;
     disp(['working and writing new DICOM files into folder ' workpath]);
     dcmdir      = dir(pth);
     dsa         = []; % = cell(1,length(dcmdir)-2); % account for . and ..
     dsametadata = []; % = cell(1,length(dcmdir)-2);
     wstatus     = [];
     for i = 3:length(dcmdir)
          try
               if (strncmp('.', dcmdir(i).name, 1)) % skip hidden system files
                    continue;
               end
               xametadata                              = dicominfo([pth '/' dcmdir(i).name]);
               xa                                      = dicomread(xametadata);
               dsametadata.SeriesInstanceUID           = dicomuid;
               dsametadata.StudyDate                   = xametadata.StudyDate;
               dsametadata.StudyTime                   = xametadata.StudyTime;
               dsametadata.ReferringPhysicianName      = xametadata.PerformingPhysicianName;
               dsametadata.PatientName                 = xametadata.PatientName;
               dsametadata.PatientID                   = xametadata.PatientID;
               dsametadata.NumberOfFrames              = xametadata.NumberOfFrames;
               dsametadata.FrameIncrementPointer       = xametadata.FrameIncrementPointer;
               dsametadata.PixelAspectRatio            = xametadata.PixelAspectRatio;
               dsametadata.PixelIntensityRelationship  = xametadata.PixelIntensityRelationship;
               dsametadata.StudyDescription            = 'DSA at the Cerebrovascular Laboratory';
               dsametadata.InstitutionName             = 'Washington University School of Medicine';
               dsametadata.InstitutionalDepartmentName = 'Mallinckrodt Institute of Radiology';
               
               if (usemsk)
                    xa  =         double(xa);
                    msk = squeeze(double(msk));
                    %assert(size(xa(:,:,1,1)) == size(msk), ['size(xa(:,:,1,1) = ' num2str(size(xa(:,:,1,1))) ... 
                    %                                              ' size(msk) = ' num2str(size(msk))]);
                    for j = 1:size(xa,4);
                         xa(:,:,1,j) = xa(:,:,1,j) .* msk;
                    end
               end
               dsa = make_uint8(move_and_average(double(xa), tau));
               wstatus = dicomwrite(dsa, ...
                    [workpath '/' dcmdir(i).name '_frame'], ...
                    dsametadata, ...
                    'ObjectType', IOD); 
          catch ME
               disp(ME.message);
               if (length(wstatus) > 1)
                    disp(wstatus.BadAttribute);
                    disp(wstatus.MissingCondition);
                    disp(wstatus.MissingData);
                    disp(wstatus.SuspectAttribute);
               end
               warning('dsa_moving_average:IOError', ...
                      ['oops...   dsa_moving_average had a problem reading or writing DICOM files with filenames:  ' ...
                       workpath '/' dcmdir(i).name ' *.']);
          end
          dsametadata
          dsa; % dip_image(dsa)
     end
end

% Usage:   uout = make_uint8(din)
%
%          uout:  uint8 array
%          din:   any array convertible to double

function uout = make_uint8(din)

     MAXUINT8 = 255;
     
     rank = length(size(din));
     mx   = 0;
     mn   = 0;
     switch (rank)
          case 4
               mx = max(max(max(max(din))));
               mn = min(min(min(min(din))));
          case 3
               mx = max(max(max(din)));
               mn = min(min(min(din)));
          case 2
               mx = max(max(din));
               mn = min(min(din));
          otherwise
               error('dsa_moving_average:make_uint8:rank', ...
                     ['rank of passed array was -> ' rank ' which is not supported']);
     end
     scale = MAXUINT8/(mx - mn);
     uout  = uint8(scale*(din - mn*ones(size(din))));
end

% Usage:  dsa = move_and_average(dblein, tau)
%
%         dsa, dblein:  double arrays
%         tau:          duration over which values are averaged

function dsa = move_and_average(dblein, tau)

     if (~isa(dblein, 'double'))
          dblein = double(dblein);
     end
     baseln = dblein(:,:,1,1:tau);
     baseln = sum(baseln,4)./tau;

     szs = size(dblein);
     dsa = zeros(szs);
     for t = 1:tau-1
          tmp = zeros(szs(1),szs(2),1,1);
          for u = 0:t-1
               tmp = tmp + dblein(:,:,1,t-u);
          end
          dsa(:,:,1,t) = tmp./t - baseln;
     end
     for t = tau:szs(4)
          tmp = zeros(szs(1),szs(2),1,1);
          for u = 0:tau-1
               tmp = tmp + dblein(:,:,1,t-u);
          end
          dsa(:,:,1,t) = tmp./tau - baseln;
     end
end

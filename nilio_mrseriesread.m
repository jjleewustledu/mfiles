%NILIO_MRSERIESREAD   Read raw MR data from file
%
% SYNOPSIS:
%  mont3d = nilio_mrseriesread(slices, times, mont, ptinfo)
%
% PARAMETERS:
%  slices.max
%        .offset
%        .num2view
%   times.max
%        .offset
%        .num2view
%        .stepsize
%  ptinfo.dir
%        .vcnum
%        .SPInum
%        .ser1
%        .ima1
%        .serLast
%        .imaLast
%    mont.cols
%        .rows
%
% NOTES:
%  All the .ima files from np287/vc* are from a Siemens Magnetom Vision.
%  They appear to be in Siemens-modified SPI format.  
%
%  The .ima files have 137,216 bytes corresponding to 6144*char header information 
%  followed by 256*256*int16 image information.
%
%  D. Clunie has a unix app. that will convert proprietary formats to DICOM,
%  which may be useful since Matlab will directly read DICOM.  
%  Cf. http://www.dclunie.com/medical-image-faq/html/
%
%  John Lee, Mar-Jun 2003.  Currently supporting only the
%  Siemens-modified SPI format, stored as big-endian int16.  
%  Silently discarding SPI header data.

function mont3d = nilio_mrseriesread(slices, times, mont, ptinfo)

% private parameters
Verbose = 1;
NRawBytes = 137216;
PixelBytes = 2;
NHdrBytes = 6144;
Dim = 256; 
StructImg = [Dim,Dim];
img2d = newim(Dim, Dim); % expected by function dip_image

if Verbose 
    disp( '>> entering nilio_mrseriesread');
    disp(['   Reading images from ' ptinfo.dir]); 
    disp(['   SPI# is '          int2str(ptinfo.SPInum)]); 
    disp(['   First series# is ' int2str(ptinfo.ser1)]); 
    disp(['   First ima# is '    int2str(ptinfo.ima1)]); 
    disp(['   Last series# is '  int2str(ptinfo.serLast)]); 
    disp(['   Last ima# is '     int2str(ptinfo.imaLast)]); 
end

% check parameters
if (NRawBytes - NHdrBytes - Dim*Dim*PixelBytes) ~= 0 ...
        error('NRawBytes, NHdrBytes and Dim are not mutually consistent'); 
end
if (slices.max - slices.offset - slices.num2view) < 0 ...
        error('slices.max, slices.offset and slices.num2view are not mutually consistent'); 
end
if (times.max  - times.offset - ((times.num2view - 1)*times.stepsize + 1)) < 0 ...
        error('times.max, times.offset, times.num2view and times.stepsize are not mutually consistent'); 
end
if (ptinfo.serLast - ptinfo.ser1 + 1) > times.num2view ...
      error('times.num2view exceeds available timeseries');
end
if (ptinfo.imaLast - ptinfo.ima1 + 1) > times.max*slices.max ...
      error('slices.num2view exceeds available slices');
end

img3d = newim(Dim, Dim, slices.num2view);
mont3d = newim(Dim*mont.cols, Dim*mont.rows, times.num2view);
monttrunc = newim(Dim*mont.cols, Dim*mont.rows);

% read raw binary data
for j = 1:times.num2view % time index
    if times.num2view > 1
      disp(['reading time ' int2str(j)]); 	  
    end
    for i = 1:slices.num2view  % slice index
      if times.num2view == 1
	disp(['reading slice ' int2str(i)]);
      end
        
        % form the file name index
        n1  = ptinfo.ser1 + times.offset + (j - 1)*times.stepsize; % magic # for time
        n2  = ptinfo.ima1 + (n1 - ptinfo.ser1)*slices.max + (slices.offset + i - 1); % magic # for slice
        imaFilename = [ptinfo.dir ptinfo.separator ...
		       int2str(ptinfo.SPInum) '-' int2str(n1) '-' int2str(n2) ...
		       '.ima'];
        if Verbose disp(['reading ' imaFilename]); end 
        [fid, message] = fopen(imaFilename, 'r', 'ieee-be'); % data was originally stored as big-endian int16
        if (fid < 0)
            disp(['fid -> ' num2str(fid) ', message -> ' message]);
        end
        hdr = fread(fid, NHdrBytes, 'uchar');  
        imgraw = fread(fid, StructImg, 'uint16');
        fclose(fid);
        img3d(:,:,i-1) = dip_image(nil_imgorder(imgraw), 'uint16'); % transpose imgraw to match
						                    % radiological conventions
    end % slice loop
    montplane = arrangeslices(img3d, mont.cols);
    sizemontplane = size(montplane);
    % NB indexing scheme of dipimage!    
    if sizemontplane(2) > Dim*mont.rows  % truncate montplane to fit mont
                                         % specifications 
      montplaneArray = double(montplane);
      monttrunc = montplaneArray(1:Dim*mont.rows,:);
      mont3d(:,:,j-1) = dip_image(monttrunc, 'uint16');
      
    elseif sizemontplane(2) < Dim*mont.rows % enlarge montplane to fit
                                            % mont specifications 
      montplaneArray = zeros(Dim*mont.rows, Dim*mont.cols);
      montplaneArray(1:sizemontplane(2),1:sizemontplane(1)) = double(montplane);
      mont3d(:,:,j-1) = dip_image(montplaneArray, 'uint16');
      
    else % sizes are just right!

      mont3d(:,:,j-1) = montplane;
    
    end
end % timestep loop

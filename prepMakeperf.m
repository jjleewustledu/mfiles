% PREPMAKEPERF
%
%   Usage:  prepMakeperf(path, ep2dBaseFilename, slicesBaseFilename)
%
%_________________________________________________________________________________________

function prepMakeperf(path, ep2dBaseFilename, slicesBaseFilename)

error('hdr file creation has a bug....');

nx = 128;
ny = 128;
nz = 13;
nt = 120
endian    = 'ieee-be';
dtype     = 'float';
imgsuffix = '.bfloat'; % .bfloat, .bshort, .bushort, .blong, .bulong, .bchar, .buchar
hdrsuffix = '.hdr';

disp(['\nprepMakeperf:  reading file ' path ep2dBaseFilename '.4dfp.img ...']);
dipimg  = read4d([path ep2dBaseFilename '.4dfp.img'], endian, dtype, nx, ny, nz, nt, 0,0,0);
hdrline = [nx; ny; nt; strcmpi(endian, 'ieee-be')];
hdrfrmt = '%1X %1X %1X %1X\n';

% write binary image files;
% write text files [path slicesBaseFilename '0' num2str(z) '.hdr'] containing:   
% [num2str(nx) num2str(ny) num2str(nt) num2str(strcmpi(endian, 'ieee-be'))]

if (nz < 11) 
    for z = 0:nz-1
        write4d(dipimg(:,:,z,:), dtype, endian, [path slicesBaseFilename '0' num2str(z) imgsuffix]);
        fid = fopen(                            [path slicesBaseFilename '0' num2str(z) hdrsuffix], 'wt');
        written = fprintf(fid, hdrfrmt, hdrline);
        fclose(fid);
        if written < 1, 
            error(['perpMakeperf:  error writing to ' 
                path slicesBaseFilename '0' num2str(z) hdrsuffix]); end
    end
elseif (nz < 101)
    for z = 0:9
        write4d(dipimg(:,:,z,:), dtype, endian, [path slicesBaseFilename '0' num2str(z) imgsuffix]);
        fid = fopen(                            [path slicesBaseFilename '0' num2str(z) hdrsuffix], 'wt');
        written = fprintf(fid, hdrfrmt, hdrline);
        fclose(fid);
        if written < 1, 
            error(['perpMakeperf:  error writing to ' 
                path slicesBaseFilename '0' num2str(z) hdrsuffix]); end
    end
  	for z = 10:nz-1
        write4d(dipimg(:,:,z,:), dtype, endian, [path slicesBaseFilename     num2str(z) imgsuffix]);
        fid = fopen(                            [path slicesBaseFilename     num2str(z) hdrsuffix], 'wt');
        written = fprintf(fid, hdrfrmt, hdrline);
        fclose(fid);
        if written < 1, 
            error(['perpMakeperf:  error writing to ' 
                path slicesBaseFilename     num2str(z) hdrsuffix]); end
    end
else
    error('prepMakeperf only supports up to 100 slices from a 4dfp image');
end

disp('\nprepMakeperf:  file listing by ls:');
system(['ls ' path]);




    


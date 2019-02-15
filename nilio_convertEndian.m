%NILIO_CONVERTENDIAN converts a 4dfp set of files from ieee-be to/from ieee-le
%
%   USAGE:
%       nilio_convertEndian(path, filenameIn, filenameOut, type, flag4dfp, endianIn, endianOut)
%
%       path           -> complete path, using '\\' as necessary for 
%                         MS Windows
%       filenameIn/Out -> filename prefix if flag4dfp == 1
%                         complete filename if flag4dfp == 0
%       type           -> datatype recognized by nilio_checkType
%       flag4dfp       -> integer boolean
%       endianIn/Out   -> cf. help fopen
%
%   SEE ALSO:
%       nilio_checkType
%       fopen
%__________________________________________________________________________

function nilio_convertEndian(path, filenameIn, filenameOut, type, flag4dfp, endianIn, endianOut)

if (strcmp('', filenameIn)) error('nilio_convertEndian:  oops... missing filenameIn'); end
nilio_checkType(type); % throws error as needed

IFH0 = 'INTERFILE	:=\nversion of keys	:= 3.3\nnumber format		:= float\nconversion program	:= nilio_convertEndian\nname of data file	:= ';
IFH1 = '\nnumber of bytes per pixel	:= 4\norientation		:= 2\nnumber of dimensions   := 4\nmatrix size [1]	:= 64\nmatrix size [2]	:= 64\nmatrix size [3]	:= 12\nmatrix size [4]	:= 80\nscaling factor (mm/pixel) [1]	:= 3.437500\nscaling factor (mm/pixel) [2]	:= 3.437500\nscaling factor (mm/pixel) [3]	:= 5.000000\n';

if (strcmp('ieee-le', endianIn) | strcmp('l', endianIn))
    IMG_IN = '.ieee-le.4dfp.img';
    IFH_IN = '.ieee-le.4dfp.ifh';
    REC_IN = '.ieee-le.4dfp.img.rec';
else
    IMG_IN = '.4dfp.img';
    IFH_IN = '.4dfp.ifh';
    REC_IN = '.4dfp.img.rec';
end

if (strcmp('ieee-le', endianOut) | strcmp('l', endianOut))
    IMG_OUT = '.ieee-le.4dfp.img';
    IFH_OUT = '.ieee-le.4dfp.ifh';
    REC_OUT = '.ieee-le.4dfp.img.rec';
else
    IMG_OUT = '.4dfp.img';
    IFH_OUT = '.4dfp.ifh';
    REC_OUT = '.4dfp.img.rec';
end

FLAG_IMG = 1;
FLAG_IFH = 1;
FLAG_REC = 0;

              % =============================================================
if (flag4dfp) % process all 4dfp files, using filenameIn as a filename prefix
              % =============================================================
    
    if (FLAG_IMG)
        finId = fopen(strcat([path filenameIn IMG_IN]), 'r', endianIn);
        try
            dataIn = fread(finId, type);
        catch
            error(['nilio_convertEndian:  oops... fread ' path filenameIn IMG_IN...
                   ' failed\nerror message:  ' ferror(finId)]);
        end
        fclose(finId);

        foutId = fopen(strcat([path filenameOut IMG_OUT]), 'w+', endianOut);
        try
            fwrite(foutId, dataIn, type);
        catch
            error(['nilio_convertEndian:  oops... fwrite ' path filenameOut IMG_OUT...
                   ' failed\nerror message:  ' ferror(foutId)]);
        end
        fclose(foutId);
    end
    
    if (FLAG_IFH)
        %%%ifhInId = fopen(strcat([filenameOut IFH_IN]));
        %%%fclose(ifhInId);

        ifhoutId = fopen(strcat([path filenameOut IFH_OUT]), 'w+');
        try
            %%%fprintf(1,        strcat([IFH0 filenameOut IFH_OUT IFH1]));
            fprintf(ifhoutId, strcat([IFH0 filenameOut IMG_OUT IFH1]));
        catch
            message = ferror(ifhoutId);
            error(['nilio_convertEndian:  oops... fwrite ' path filenameOut IFH_OUT...
                   ' failed\nerror message:  ' message]);
        end
        fclose(ifhoutId);
    end
    
    if (FLAG_REC)
    %%%recInId = fopen(strcat([filenameOut REC_IN]));
    %%%fclose(recInId);
    
    %%%recOutId = fopen(strcat([filenameOut REC_OUT]));
    %%%fclose(recOutId);
    end
    
     % =============================================
else % process the filenameIn as a complete filename
     % =============================================
       
    [fid, message] = fopen(filenameIn, 'r', endianIn);
    if (fid < 0)
        disp(['fid -> ' num2str(fid) ', message -> ' message]);
    end
    try
        dataIn = fread(fid, type);
    catch
        error(['nilio_convertEndian:  oops... fread ' filenameIn...
               ' failed\nerror message:  ' ferror(fid)]);
    end
    fclose(fid);
    
    [gid, message] = fopen(filenameOut, 'w+', endianOut);
    if (gid < 0)
        disp(['gid -> ' num2str(gid) ', message -> ' message]);
    end
    try
        fwrite(gid, dataIn, type);
    catch
        error(['nilio_convertEndian:  oops... fwrite ' filenameOut...
               ' failed\nerror message:  ' ferror(gid)]);
    end
    fclose(gid);
    
end

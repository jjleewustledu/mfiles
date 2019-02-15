%
% m-file that can open Varian FDF imaging files in Matlab.
%
% Usage: [hdr img] = nilio_fdf(fqfilename, study);
%        hdr -> header data
%        img -> image data as DIPimage object
%
% After:
% Shanrong Zhang
% Department of Radiology
% University of Washington
% 
% email: zhangs@u.washington.edu
% 12/19/2004
% 

function [img hdr] = nilio_fdf(fqfilename, study)

    VERBOSE = 0;
    LINE_LIMIT = 32;
    warning off MATLAB:divideByZero;
    
    switch (nargin)
        case 1
            study = 'np755';
        case 2
        otherwise
            error(help('nilio_fdf'));
    end

    fprintf('nilio_fdf:  fopening file %s\n', fqfilename);
    [fid, message] = fopen(fqfilename,'r','b');
    if (fid < 0)
        disp(['fid -> ' num2str(fid) ', message -> ' message]);
    end

    num = 0;
    done = false;
    line = fgetl(fid);
    if VERBOSE, disp(line); end
    hdr = line;
    while (~isempty(line) && ~done)
        line = fgetl(fid);
        if VERBOSE, disp(line); end
        hdr = strcat(hdr, '\n', line);
        if strmatch('float  matrix[] = ', line)
            [token, rem] = strtok(line,'float  matrix[] = { , };'); %% BUG:   misuse of strtok
            M(1) = str2num(token);
            M(2) = str2num(strtok(rem,', };')); %% BUG:   misuse of strtok
        end
        if strmatch('float  bits = ', line)
            [token, rem] = strtok(line,'float  bits = '); %% BUG:   misuse of strtok
            bits = str2num(token);
        end
        if strmatch('int    slice_no =', line)
            [token, rem] = strtok(line,'int    slice_no ='); %% BUG:   misuse of strtok
            sliceno = str2num(token);
        end

        num = num + 1;

        if num > LINE_LIMIT
            done = true;
        end
    end

    shift = fseek(fid, -M(1)*M(2)*bits/8, 'eof');
    % If your image shifted, you may turn "shift...." off by add a "%" before
    % shift.

    img = fread(fid, [M(1), M(2)], 'float32');
    fclose(fid);
    
    disp(['fread.img has dimensions [' num2str(size(img,1)) ' ' num2str(size(img,2)) ']']);
    switch (study)
        case 'np287'
            img = flipx4d(flipy4d(img'));
        case {'np797', 'np755'}
            img = flipy4d(img);
        otherwise
            error(['nilio_fdf:  could not recognize ' study]);
    end

    

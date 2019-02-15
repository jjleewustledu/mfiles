function img = fdf
% m-file that can open Varian FDF imaging files in Matlab.
% Usage: img = fdf;
% Your image data will be loaded into img
%
% Shanrong Zhang
% Department of Radiology
% University of Washington
% 
% email: zhangs@u.washington.edu
% 12/19/2004
% 
warning off MATLAB:divideByZero;

[filename pathname] = uigetfile('*.fdf','Please select a file');

fid = fopen([pathname filename],'r','b');

num = 0;
done = false;
line = fgetl(fid);
% disp(line)
while (~isempty(line) && ~done)
    line = fgetl(fid);
    % disp(line)
    if strmatch('float  matrix[] = ', line)
        [token, rem] = strtok(line,'float  matrix[] = { , };');
        M(1) = str2num(token);
        M(2) = str2num(strtok(rem,', };'));
    end
    if strmatch('float  bits = ', line)
        [token, rem] = strtok(line,'float  bits = { , };');
        bits = str2num(token);
    end

    num = num + 1;
    
    if num > 33
        done = true;
    end
end

shift = fseek(fid, -M(1)*M(2)*bits/8, 'eof');
% If your image shifted, you may turn "shift...." off by add a "%" before
% shift.

img = fread(fid, [M(1), M(2)], 'float32');
img = img';
figure;
imshow(img, []); 
%imview(img, []);
colormap(gray);
axis image;
axis off;
fclose(fid);

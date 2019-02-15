%NILIO_READASCII reads floating-point data in Larry Bretthorst's 
%                ascii format
%
% SYNOPSIS:
%  dip_out = nilio_readAscii(filename, dim1, dim2, dim3, dim4)
%
% NOTES:
%  resulting 4dfp dip-images will be in radiologic convention 
%  when viewed with DIPimage
%
% PARAMETERS:
%  filename               - string with name of file
%  dim1, dim2, dim3, dim4 - 4dfp dimensions
%
% $Author$
% $Date$
% $Revision$
% $Source$

function dipOut = nilio_readAscii(filename, dim1, dim2, dim3, dim4)

disp('entering nilio_readAscii .....');

% private parameters
VERBOSE = 1;
FORMAT = '%n'; 

% check for silly inputs
if (strcmp('', filename)) error('nilio_read4d:  oops... missing filename'); end
if (dim1 < 1) error('nilio_read4d:  oops... dim1 < 1'); end
if (dim2 < 1) error('nilio_read4d:  oops... dim2 < 1'); end
if (dim3 < 1) error('nilio_read4d:  oops... dim3 < 1'); end
if (dim4 < 1) error('nilio_read4d:  oops... dim4 < 1'); end

if (1 == VERBOSE) disp('preallocating arrays'); end
arr1d  = zeros(1, dim1);
arr4d  = zeros(dim2, dim1, dim3, dim4);
dipOut = newim(dim2, dim1, dim3, dim4);

if (VERBOSE) disp(['textscanning ' num2str(dim1*dim2*dim3*dim4) ' values from ' filename ' .....']); end

fid   = fopen(filename);
for t = 1:dim4
    for z = 1:dim3
        for y = 1:dim2
            arr1d = cell2mat(textscan(fid, FORMAT, dim1));
            arr4d(x,y,z,t) = arr1d';
            %%% textscan(fid, FORMAT, 1);
        end
    end
end
fclose(fid);

dipOut = dip_image(arr4d);

% dipOut  = dip_image(arr4d);
% for t = 0:dim4-1
%     for z = 0:dim3-1
%         for y = 0:dim2-1
%             for x = 0:dim1-1
%                 dipOut(dim1-1-x,dim2-1-y,z,t) = dipOut(x,y,z,t)
%             end
%         end
%     end
% end



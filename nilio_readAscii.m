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

function dipOut = nilio_readAscii(filename, dim1, dim2, dim3, dim4, varargin)

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
dipOut = newim(dim1, dim2, dim3, dim4);

if (VERBOSE) disp(['textscanning ' num2str(dim1*dim2*dim3*dim4) ' values from ' filename ' .....']); end

[fid, message] = fopen(filename);
if (fid < 0)
    disp(['fid -> ' num2str(fid) ', file -> ' filename ', message -> ' message]);
end
if (nargin > 5 & varargin{1})
    disp(['nilio_readAscii will read from ' filename]);
end
for t = 0:dim4-1
    for z = 0:dim3-1
        %%% disp(['z -> ' num2str(z)]);
        for y = 0:dim2-1
            %%% disp(['y -> ' num2str(y)]);
            arr1d = cell2mat(textscan(fid, FORMAT, dim2));
            dipOut(:,y,z,t) = arr1d';
        end
    end
end
fclose(fid);

dipOut = flipdim(flipdim(dipOut, 1), 2);


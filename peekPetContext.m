%PEEKPETCONTEXT
%
% Usage:  theImg = peekPetContext('vc4103', 'ho1', petpath, lens, [5,1], 'dip')
%
%         gaussSigmas are the std. devs in mm; default is no filtering (optional)
%         imgFormat is 'dip' or 'double', default is 'double'
%

function theImg = peekPetContext(p, metric, petpath, lens, gaussSigmas, imgFormat)

if ~isnumeric(p), p = pidList(p); end
if nargin < 5, gaussSigmas = [0, 0]; end

blankImg  = newim(lens(1),lens(2),lens(3),lens(4));
theImg    = blankImg;
if nargin < 6, imgFormat = 'double'; end

switch char(metric)
    case 'ho1'
        fname = [petpath hoFileList(p) '.4dfp.img'];
    case 'oc1'
        fname = [petpath ocFileList(p) '.4dfp.img'];
    case 'oo1'
        fname = [petpath ooFileList(p) '.4dfp.img'];
    otherwise
        error(['peekPetContext could not recognize metric -> ' metric]);
end  
try
    theImg = read4d(fname,'ieee-be','single',lens(1),lens(2),lens(3),1,0,0,0);
    disp(['peekPetContext found ' fname]);
catch
    disp(['lens -> ' num2str(lens)]);
    warning(['peekPetContext could not find ' fname]);
end

if gaussSigmas(1) > 0 && gaussSigmas(2) > 0, 
    theImg = gaussAnisof(theImg, [gaussSigmas(1) gaussSigmas(1) gaussSigmas(2)]); end

switch (char(imgFormat))
    case 'dip'
    otherwise
        theImg = double(theImg);
end

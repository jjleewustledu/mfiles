%
%   Usage:  single_patient_image(img, sl, units, filename, range, colormap)
%
%           units    -> string to display units of the colorbar
%           filename -> stem of postscript2-color file;
%                       empty string for no file-writing
%           range    -> 2-vector of inf, sup image values
%           colormap -> optional colormap
%

function single_patient_image(img, sl, units, filename, range, map)
    
	publishImage_singlepatient(img, sl, units, filename, range, map);
	
   
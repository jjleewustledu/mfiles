function dicomdump(msgname, varargin)
%DICOMDUMP  Read metadata from DICOM message.
%   DICOMDUMP(FILENAME) reads the metadata from the compliant
%   DICOM file specified in the string FILENAME and prints it.
%
%   DICOMDUMP(FILENAME, 'dictionary', D) uses the data dictionary
%   file given in the string D to read the DICOM file.  The file in
%   D must be on the MATLAB search path.  The default value is
%   dicom-dict.mat.
%
%   Example:
%
%     info = dicomdump('CT-MONO2-16-ankle.dcm');
%
%   See also DICOMDICT, DICOMINFO, DICOMREAD, DICOMWRITE, DICOMUID.

% Author: Jeff Mather
% Copyright 2006-2007 The MathWorks, Inc.
% $Revision: 1.1.2.4 $  $Date: 2007/09/26 15:01:04 $

% This function (along with DICOMREAD) implements the M-READ service.
% This function implements the M-INQUIRE FILE service.


% Parse input arguments.
if (nargin < 1)
    eid = 'Images:dicomdump:tooFewInputs';
    error(eid, '%s', 'DICOMDUMP requires at least one argument.')
    
end

% Set the dictionary.
args = parse_inputs(varargin{:});
dicomdict('set_current', args.Dictionary)

% Get the info.
try

    if (isdicom(msgname))
        get_info(msgname, varargin{:});
    else
        error('Images:dicomdump:notDICOM', ...
              'The specified file is not in DICOM format.')
    end
    
catch
    
    dicomdict('reset_current');
    rethrow(lasterror)
    
end

% Reset the dictionary.
dicomdict('reset_current');



function get_info(filename, varargin)

% Get details about the file to read.
d = dir(filename);

if (isempty(d))

  fid = fopen(filename);

  if (fid < 0)
    
    error('Images:dicomdump:fileNotFound', ...
          'File "%s" not found.', filename);
    
  end

  filename = fopen(fid);
  d = dir(filename);
  d.name = filename;
  fclose(fid);

else
  
  d.name = filename;
  
end

% Parse the DICOM file.
attrs = dicomparse(d.name, d.bytes, getEndian, false, dicomdict('get'));

printFileDetails(d, attrs);
printHeader();
printAttributes(attrs, 0);



function printFileDetails(fileDetails, attrs)

% File and platform details.
disp(sprintf('File: %s (%d bytes)', ...
             fileDetails.name, fileDetails.bytes))
if (isequal(getEndian, 'L'))
    disp('Read on an IEEE little-endian machine.')
else
    disp('Read on an IEEE big-endian machine.')
end

% Conformance and encoding details
if (attrs(1).Group == 2)
  
    % It has proper file transfer metadata.
    disp(sprintf('File begins with group 0002 metadata at byte %d.', ...
         attrs(1).Location))
    
    % Report about the transfer syntax (0002,0010).
    idx = find(([attrs(:).Group] == 2) & ([attrs(:).Element] == 16));
    if (~isempty(idx))
        txfr = deblank(char(attrs(idx).Data));
        txfr(txfr == 0) = '';
        uidDetails = dicom_uid_decode(txfr);
        disp(sprintf('Transfer syntax: %s (%s).', txfr, uidDetails.Name))
    else
        disp('Transfer syntax not present.')
    end
    
else
  
    disp('File does not have group 0002 attributes.')
    
end

% What kind of DICOM file is it?  Attribute (0008,0016) says.
idx = find(([attrs(:).Group] == 8) & ([attrs(:).Element] == 22));
if (~isempty(idx))

    SOPClassUID = deblank(char(attrs(idx).Data));
    SOPClassUID(SOPClassUID == 0) = '';
    uidDetails = dicom_uid_decode(SOPClassUID);
    disp(sprintf('DICOM Information object: %s (%s).', ...
                 SOPClassUID, uidDetails.Name));
    
else
  
    disp('SOP Class UID attribute (0008,0016) not present.  Unknown type.')
    
end

% Print a blank line.
disp(' ')



function printHeader

disp(sprintf('Location  Lvl     Tag     VR         Size       %-32s Data', 'Name'))
disp(repmat('-', [1 100]))



function printAttributes(attrs, level)
% Dump the DICOM attributes.

for currentAttr = 1:numel(attrs)
  
  % Find this attribute.
  this = attrs(currentAttr);
  
  % Get the VR.
  if (isempty(this.VR))
    this.VR = '""';
  end
  
  % Get a printable version of the attribute's data.
  if (isempty(this.Data))
    data = '[]';

  elseif (isstruct(this.Data))
    printOne(this, '', level)
    printAttributes(this.Data, level + 1);
    continue
    
  elseif (any(this.Data(1:end-1) < 32) || any(this.Data > 126))
    data = '*Binary*';
    
  else
    data = sprintf('[%s]', char(this.Data));
    
  end

  printOne(this, data, level)
  
end



function printOne(attr, data, level)

% Display the attribute.
disp(sprintf('%07d  %3d  (%04X,%04X) %2s %10.0f bytes - %-32s %s', ...
             attr.Location, ...
             level, ...
             attr.Group, ...
             attr.Element, ...
             attr.VR, ...
             attr.Length, ...
             dicomlookup_actions(attr.Group, attr.Element), ...
             data))
  


function byteOrder = getEndian

persistent endian

if (~isempty(endian))
  byteOrder = endian;
  return
end

[c, m, endian] = computer;
byteOrder = endian;



function args = parse_inputs(varargin)

% Set default values
args.Dictionary = dicomdict('get');

% Parse arguments based on their number.
if (nargin > 1)
    
    paramStrings = {'dictionary'};
    
    % For each pair
    for k = 1:2:length(varargin)
       param = lower(varargin{k});
       
            
       if (~ischar(param))
           eid = 'Images:dicomdump:parameterNameNotString';
           msg = 'Parameter name must be a string';
           error(eid, '%s', msg);
       end

       idx = strmatch(param, paramStrings);
       
       if (isempty(idx))
           eid = 'Images:dicomdump:unrecognizedParameterName';
           msg = sprintf('Unrecognized parameter name "%s"', param);
           error(eid, '%s', msg);
       elseif (length(idx) > 1)
           eid = 'Images:dicomdump:ambiguousParameterName';
           msg = sprintf('Ambiguous parameter name "%s"', param);
           error(eid, '%s', msg);
       end
    
       switch (paramStrings{idx})
       case 'dictionary'

           if (k == length(varargin))
               eid = 'Images:dicomdump:missingDictionary';
               msg = 'No data dictionary specified.';
               error(eid, '%s', msg);
           else
               args.Dictionary = varargin{k + 1};
           end

       end  % switch
       
    end  % for
           
end

%
%  USAGE:  [fid] = nilio_writeIfh(ifhstruct, fqfname)
%
%          ifhstruct:	Matlab struct containing at minimum:
%                       nameOfDataFile
%                       patientID
%                       numberFormat
%                       orientation
%                       scalingFactors
%                       sliceThickness
%                       lengths                       
%
%          fqfname:		description
%
%          fid:			description
%
%  Created by John Lee on 2008-04-27.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function [fid] = nilio_writeIfh(ifhstruct, fqfname)

    MACHINE_BITS = 32;
    
	switch (nargin)
		case 2
		otherwise
			error(help('nilio_writeIfh'));
	end
	
	
	
	% CHECK PRESENCE OF REQUIRED FIELDS
	
	if (~isfield(ifhstruct, 'nameOfDataFile'))
	    error('nilio_writeIfh2:  could not find ifhstruct.nameOfDataFile'); end
	if (~isfield(ifhstruct, 'patientID'))
	    error('nilio_writeIfh2:  could not find ifhstruct.patientID'); end
	if (~isfield(ifhstruct, 'numberFormat'))
	    error('nilio_writeIfh2:  could not find ifhstruct.numberFormat'); end
	if (~isfield(ifhstruct, 'orientation'))
	    error('nilio_writeIfh2:  could not find ifhstruct.orientation'); end			
	if (~isfield(ifhstruct, 'scalingFactors'))
	    error('nilio_writeIfh2:  could not find ifhstruct.scalingFactors'); end
	if (~isfield(ifhstruct, 'sliceThickness'))
	    error('nilio_writeIfh2:  could not find ifhstruct.sliceThickness'); end
	if (~isfield(ifhstruct, 'lengths'))
	    error('nilio_writeIfh2:  could not find ifhstruct.lengths'); end			
	
	
	
	% DO BUSINESS
	
	fid = fopen(fqfname, 'wt');

	fprintf(fid, 'INTERFILE :=\n');
	fprintf(fid, 'version of keys := 3.3\n');
	fprintf(fid, 'original institution := Washington University\n');
	if (isfield(ifhstruct, 'originatingSystem'))
	    fprintf(fid, 'originating system := %s\n', ifhstruct.originatingSystem); end
	if (isfield(ifhstruct, 'imageModality'))
	    fprintf(fid, 'image modality := %s\n', ifhstruct.imageModality); end
	if (isfield(ifhstruct, 'model'))
	    fprintf(fid, 'model := %s\n', ifhstruct.model); end
	if (isfield(ifhstruct, 'conversionProgram'))
	    fprintf(fid, 'conversion program := %s\n', ifhstruct.conversionProgram); end
	if (isfield(ifhstruct, 'programVersion'))
	    fprintf(fid, 'program version := %s\n', ifhstruct.programVersion); end	
	fprintf(fid, 'name of data file := %s\n', ifhstruct.nameOfDataFile);
	fprintf(fid, 'patient ID := %s\n', ifhstruct.patientID);
	if (isfield(ifhstruct, 'studyDate'))
		fprintf(fid, 'study date := %s\n', ifhstruct.studyDate); end
	fprintf(fid, 'processing date := %s\n', datestr(now));
	fprintf(fid, 'number format := %s\n', ifhstruct.numberFormat);
    switch (ifhstruct.numberFormat)
        case {'float','single'}
            ifhstruct.bytesPerPixel = MACHINE_BITS/8;
        case 'double'
            ifhstruct.bytesPerPixel = MACHINE_BITS/4;
        otherwise
            error(['nilio_writeIfh:  could not recognize numberFormat -> ' ifhstruct.numberFormat]);
    end
	if (ifhstruct.bytesPerPixel > 0)
	    fprintf(fid, 'number of bytes per pixel := %i\n', ifhstruct.bytesPerPixel); end
	fprintf(fid, 'orientation := %i\n', ifhstruct.orientation);
	if (isfield(ifhstruct, 'numberOfDimensions'))
	    fprintf(fid, 'number of dimensions := %i\n', ifhstruct.numberOfDimensions); end
	fprintf(fid, 'matrix size [1] := %i\n', ifhstruct.lengths(1));
	fprintf(fid, 'matrix size [2] := %i\n', ifhstruct.lengths(2));
	fprintf(fid, 'matrix size [3] := %i\n', ifhstruct.lengths(3));
	fprintf(fid, 'matrix size [4] := %i\n', ifhstruct.lengths(4));
	fprintf(fid, 'scaling factor (mm/pixel) [1] := %f\n', ifhstruct.scalingFactors(1));
	fprintf(fid, 'scaling factor (mm/pixel) [2] := %f\n', ifhstruct.scalingFactors(2));
	fprintf(fid, 'scaling factor (mm/pixel) [3] := %f\n', ifhstruct.scalingFactors(3));
	fprintf(fid, 'slice thickness (mm/pixel) := %f\n', ifhstruct.sliceThickness);
	if (isfield(ifhstruct, 'parameterFilename'))
	    fprintf(fid, 'mri parameter file name := %s\n', ifhstruct.parameterFilename); end
	if (isfield(ifhstruct, 'sequenceFilename'))
	    fprintf(fid, 'mri sequence file name := %s\n', ifhstruct.sequenceFilename); end
	if (isfield(ifhstruct, 'sequenceDescription'))    
	    fprintf(fid, 'mri sequence description := %s\n', ifhstruct.sequenceDescription); end
	if (isfield(ifhstruct, 'comment'))
	    fprintf(fid, 'comment := %s\n', ifhstruct.comment); end

	fclose(fid);
	

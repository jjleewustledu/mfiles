%
%  USAGE:  mfName = mrFolderName(study)
%
%          study:	description
%
%          mfName:	description
%
%  Created by John Lee on 2008-04-23.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function mfName = mrFolderName(study)

	switch (nargin)
		case 1
		otherwise
			error(help('mrFolderName'));
	end
	
	switch (study)
		case 'np287'
			mfName = '4dfp/';
		case 'np797'
			mfName = '4dfp/';
		otherwise
			error(['mrFolderName:  could not recognize study -> ' study]);
	end
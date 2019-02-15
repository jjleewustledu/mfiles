%
%  USAGE:  pfName = petFolderName(study)
%
%          study:	description (option)
%
%          pfName:	description
%
%  Created by John Lee on 2008-04-23.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function pfName = petFolderName(study)

	switch (nargin)
        case 0
            pfName = '962_4dfp/';
            return
		case 1
            switch (study)
                case 'np287'
                    pfName = 'PET/';
                case 'np797'
                    pfName = '962_4dfp/';
                otherwise
                    error(['petFolderName:  could not recognize study -> ' study]);
            end
		otherwise
			error(help('petFolderName'));
	end
	
	
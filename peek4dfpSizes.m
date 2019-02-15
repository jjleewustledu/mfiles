%
%  USAGE:  sizes = peek4dfpSizes(study)
%
%          study:       string, e.g., 'np797'
%
%  Created by John Lee on 2008-04-09.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function sizes = peek4dfpSizes(study)

    switch (nargin)
        case 0
            sizes = [256 256 8 1];
        case 1
            switch (study)
                case 'np287'
                    sizes = [256 256 8 60];
                case 'np797'
                    sizes = [128 128 13 120];
                otherwise
                    error(['peek4dfpSizes:  could not recognize study ' study]);
            end
		otherwise
			error(help('peek4dfpSizes'));
    end
    
	
